//
//  CoverCellView.swift
//  pokedexifood
//
//  Created by Caroline Taus on 29/03/25.
//
import UIKit
import SnapKit

final class CoverCellView: UICollectionViewCell {
    lazy var container: UIView = {
        return UIView()
    }()

    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUpHierarchy()
        setUpConstraint()
        setUpStyle()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpHierarchy() {
        contentView.addSubview(container)
        container.addSubview(imageView)
    }

    private func setUpConstraint() {
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }

        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setUpStyle() {
        container.backgroundColor = .viewBackground
        container.layer.cornerRadius = 40
    }

    func configure(image: UIImage) {
        imageView.image = image
    }
}

extension CoverCellView {
    static var coverRegistration: UICollectionView.CellRegistration<CoverCellView, UIImage> {
        return .init { cell, _, image in
            cell.configure(image: image)
        }
    }
}
