//
//  PoketypeCellView.swift
//  pokedexifood
//
//  Created by Caroline Taus on 29/03/25.
//

import UIKit
import SnapKit

final class PoketypeCellView: UICollectionViewCell {
    lazy var container: UIView = {
        return UIView()
    }()

    lazy var typeLabel: UILabel = {
        return UILabel()
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
        container.addSubview(typeLabel)
    }

    private func setUpConstraint() {
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        typeLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }

    private func setUpStyle() {
        container.backgroundColor = .viewBackground
        container.layer.cornerRadius = 28

        typeLabel.textAlignment = .center
        typeLabel.font = UIFont.preferredFont(forTextStyle: .title3)
    }

    func configure(model: PoketypeViewModel) {
        typeLabel.text = model.typeName
        typeLabel.textColor = model.typeColor
        container.backgroundColor = model.typeColor.withAlphaComponent(0.2)
    }
}

extension PoketypeCellView {
    static var poketypeRegistration: UICollectionView.CellRegistration<PoketypeCellView, PoketypeViewModel> {
        return .init { cell, _, model in
            cell.configure(model: model)
        }
    }
}
