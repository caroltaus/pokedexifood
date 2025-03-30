//
//  PokemonDetailViewController.swift
//  pokedexifood
//
//  Created by Caroline Taus on 27/03/25.
//
import UIKit
import SnapKit

protocol PokemonDetailViewControllerProtocol: AnyObject {
    func displayData(sections: [PokemonDetailSection])
    func displayLoadingScreen(value: Bool)
    func displayErrorAlert(title: String, message: String, buttonTitle: String)
    func displayPokemonName(name: String)
}

final class PokemonDetailViewController: UIViewController {
    private let interactor: PokemonDetailInteractorProtocol
    private var loadingView = LoadingView(frame: .zero)

    // Collection Elements
    private lazy var layout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, environment in
            guard let self,
                  let section = self.dataSource.sectionIdentifier(for: sectionIndex) else {
                return .list(using: .init(appearance: .plain), layoutEnvironment: environment)
            }
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: .estimated(44))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)

            switch section {
            case .cover:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(400)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

                let section = NSCollectionLayoutSection(group: group)
                return section

            case .pokemonTypes:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1/3),
                    heightDimension: .fractionalHeight(1)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(56)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.interItemSpacing = .fixed(16)

                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 8, leading: 16, bottom: 8, trailing: 16)
                section.boundarySupplementaryItems = [sectionHeader]
                return section

            case .stats:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .estimated(130),
                    heightDimension: .estimated(120)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 8, leading: 16, bottom: 8, trailing: 16)
                section.interGroupSpacing = 16
                section.orthogonalScrollingBehavior = .continuous
                section.boundarySupplementaryItems = [sectionHeader]
                return section

            case .moves:
                let section = NSCollectionLayoutSection.list(
                    using: .init(appearance: .insetGrouped),
                    layoutEnvironment: environment
                )
                section.boundarySupplementaryItems = [sectionHeader]
                return section
            }
        }
        return layout
    }()

    private let moveCellRegistration = UICollectionViewListCell.moveRegistration
    private let coverCellRegistration = CoverCellView.coverRegistration
    private let statCellRegistration = StatCellView.statRegistration
    private let poketypeCellRegistration = PoketypeCellView.poketypeRegistration
    private var headerRegistration: UICollectionView.SupplementaryRegistration<SectionTitleView>?

    private lazy var collectionView: UICollectionView = {
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()

    private lazy var dataSource: UICollectionViewDiffableDataSource<SectionType, Item> = {
        let dataSource = UICollectionViewDiffableDataSource<SectionType, Item>(
            collectionView: collectionView,
            cellProvider: { [weak self] collectionView, index, item in
                guard let self else {
                    return UICollectionViewCell()
                }
                return self.buildCell(for: collectionView, at: index, with: item)
            })

        dataSource.supplementaryViewProvider = { [weak self] _, _, index in
            guard let self,
                  let header = self.headerRegistration else { return nil }
            return self.collectionView.dequeueConfiguredReusableSupplementary(
                using: header, for: index)
        }
        return dataSource
    }()

    init(interactor: PokemonDetailInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        view.backgroundColor = .viewBackground
        self.headerRegistration = UICollectionView
            .SupplementaryRegistration<SectionTitleView>(
                elementKind: UICollectionView.elementKindSectionHeader
            ) { [weak self] supplementaryView, _, indexPath in
                guard let self,
                      let sectionTitle = self.dataSource.sectionIdentifier(for: indexPath.section)?.title
                else {
                    return
                }
                supplementaryView.configure(title: sectionTitle)
            }
        setUpHierarchy()
        setUpConstraints()

        Task {
            await interactor.loadData()
        }
        loadingView.loading(false)
    }

    override func viewWillAppear(_ animated: Bool) {
        UIBarButtonItem.appearance().tintColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true

    }

    private func setUpHierarchy() {
        view.addSubview(loadingView)
        view.addSubview(collectionView)
    }

    private func setUpConstraints() {
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func buildCell(
        for collectionView: UICollectionView,
        at indexPath: IndexPath,
        with item: Item
    ) -> UICollectionViewCell {
        switch item {
        case .picture(let image):
            return collectionView.dequeueConfiguredReusableCell(
                using: coverCellRegistration,
                for: indexPath,
                item: image
            )
        case .poketype(let poketypeViewModel):
            return collectionView.dequeueConfiguredReusableCell(
                using: poketypeCellRegistration,
                for: indexPath,
                item: poketypeViewModel
            )
        case .stat(let statViewModel):
            return collectionView.dequeueConfiguredReusableCell(
                using: statCellRegistration,
                for: indexPath,
                item: statViewModel
            )
        case .move(let string):
            return collectionView.dequeueConfiguredReusableCell(
                using: moveCellRegistration,
                for: indexPath,
                item: string
            )
        }
    }
}

extension PokemonDetailViewController: PokemonDetailViewControllerProtocol {
    func displayPokemonName(name: String) {
        navigationItem.title = name
    }

    func displayData(sections: [PokemonDetailSection]) {
        var snapshot = NSDiffableDataSourceSnapshot<SectionType, Item>()
        snapshot.appendSections(sections.map(\.section))
        sections.forEach { section in
            snapshot.appendItems(section.items, toSection: section.section)
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    func displayLoadingScreen(value: Bool) {
        loadingView.loading(value)
    }

    func displayErrorAlert(title: String, message: String, buttonTitle: String) {}
}
