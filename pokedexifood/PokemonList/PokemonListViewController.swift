//
//  PokemonListViewController.swift
//  pokedex
//
//  Created by Caroline Taus on 25/03/25.
//

import UIKit
import SnapKit
import FLAnimatedImage

@MainActor
protocol PokemonListViewControllerProtocol: AnyObject {
    func displayData(viewModels: [PokemonListCellViewModel])
    func updateShouldLoadMore(value: Bool)
    func displayLoadingScreen(value: Bool)
    func displayErrorAlert(title: String, message: String, buttonTitle: String)
}

final class PokemonListViewController: UIViewController {
    enum Section {
        case main
    }

    private let interactor: PokemonListInteractorProtocol
    private let coordinator: PokemonListCoordinatorProtocol
    private var shouldLoadMore: Bool = false
    private var loadingView = LoadingView(frame: .zero)

    // Collection Elements
    private let registration = PokemonListCellView.cellRegistration

    private lazy var collectionView: UICollectionView = {
        var layoutConfig = UICollectionLayoutListConfiguration(appearance: .plain)
        layoutConfig.showsSeparators = false
        let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
        return UICollectionView(frame: .zero, collectionViewLayout: listLayout)
    }()

    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, PokemonListCellViewModel> = {
        return UICollectionViewDiffableDataSource<Section, PokemonListCellViewModel>(
            collectionView: collectionView,
            cellProvider: { [weak self] collectionView, index, item in
            guard let self else {
                return UICollectionViewCell()
            }
            return self.buildCell(for: collectionView, at: index, with: item)
        })
    }()

    init(
        interactor: PokemonListInteractorProtocol,
        coordinator: PokemonListCoordinatorProtocol
    ) {
        self.interactor = interactor
        self.coordinator = coordinator

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pokedex"
        view.backgroundColor = .viewBackground

        collectionView.dataSource = dataSource
        collectionView.delegate = self

        setUpHierarchy()
        setUpConstraints()
        Task {
            await interactor.loadData()
        }

        loadingView.loading(false)
    }

    override func viewWillAppear(_ animated: Bool) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = UIColor.pokered
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
    }

    private func setUpHierarchy() {
        view.addSubview(collectionView)
        view.addSubview(loadingView)
    }

    private func setUpConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func buildCell(
        for collectionView: UICollectionView,
        at indexPath: IndexPath,
        with item: PokemonListCellViewModel
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueConfiguredReusableCell(
            using: registration,
            for: indexPath,
            item: item)

        return cell
    }
}

extension PokemonListViewController: PokemonListViewControllerProtocol {
    func displayData(viewModels: [PokemonListCellViewModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, PokemonListCellViewModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModels, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    func updateShouldLoadMore(value: Bool) {
        shouldLoadMore = value
    }

    func displayLoadingScreen(value: Bool) {
        loadingView.loading(value)
    }

    func displayErrorAlert(title: String, message: String, buttonTitle: String) {
        coordinator.showErrorAlert(
            title: title,
            message: message,
            buttonTitle: buttonTitle) { [weak self] in
                Task {
                    await self?.interactor.tryAgain()
                }
            }
        shouldLoadMore = false
    }
}

extension PokemonListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        coordinator.goToPokemonDetail(id: item.id)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        let totalItems = dataSource.snapshot().numberOfItems

        if shouldLoadMore, indexPath.row == totalItems-1 {
            shouldLoadMore = false
            Task {
                await interactor.loadData()
            }
        }
    }
}
