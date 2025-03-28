//
//  PokemonListCellView.swift
//  pokedexifood
//
//  Created by Caroline Taus on 26/03/25.
//

import UIKit
import SnapKit

class PokemonListCellView: UICollectionViewCell {
    // Containers
    private lazy var container: UIView = {
        return UIView()
    }()
    
    private lazy var cellContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var textContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    
    // Subviews
    private lazy var cellTitle: UILabel = {
        return UILabel()
    }()
    
    private lazy var cellSubtitle: UILabel = {
        return UILabel()
    }()
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpHierarchy()
        setUpConstraints()
        setUpStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpHierarchy() {
        contentView.addSubview(container)
        container.addSubview(cellContainer)
        textContainer.addArrangedSubview(cellTitle)
        textContainer.addArrangedSubview(cellSubtitle)
        textContainer.addArrangedSubview(UIView())
        cellContainer.addArrangedSubview(imageView)
        cellContainer.addArrangedSubview(textContainer)
        cellContainer.addArrangedSubview(UIView())
    }
    
    private func setUpConstraints() {
        container.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        cellContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        
        imageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 64, height: 64))
        }
    }
    
    private func setUpStyle() {
        container.backgroundColor = .cellBackground
        container.layer.cornerRadius = 8
        cellContainer.setCustomSpacing(24, after: imageView)
        textContainer.setCustomSpacing(8, after: cellTitle)
        imageView.layer.cornerRadius = 32
        cellTitle.font = UIFont.preferredFont(forTextStyle: .headline)
        cellSubtitle.font = UIFont.preferredFont(forTextStyle: .subheadline)
        
    }
    
    func configure(with viewModel: PokemonListCellViewModel) {
        cellTitle.text = viewModel.name
        cellSubtitle.text = viewModel.type
        
        imageView.backgroundColor = .viewBackground
        if let url = viewModel.image {
            Task {
                do {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    let image = UIImage(data: data)
                    await MainActor.run {
                        self.imageView.image = image
                    }
                }
                catch {
                    // TRATAMENTO PRA IMAGEM PADRAO
                }
            }
        }
    }
    
}

extension PokemonListCellView {
    static var cellRegistration: UICollectionView.CellRegistration<PokemonListCellView, PokemonListCellViewModel> {
        return .init { (cell, indexPath, item) in
            cell.configure(with: item)
        }
    }
}
