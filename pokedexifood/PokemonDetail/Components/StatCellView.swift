//
//  StatCellView.swift
//  pokedexifood
//
//  Created by Caroline Taus on 29/03/25.
//
import UIKit
import SnapKit

final class StatCellView: UICollectionViewCell {
    lazy var container: UIView = {
        return UIView()
    }()

    lazy var statName: UILabel = {
        return UILabel()
    }()

    lazy var statValue: UILabel = {
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
        container.addSubview(statName)
        container.addSubview(statValue)
    }

    private func setUpConstraint() {
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        statName.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(16)
            make.bottom.equalTo(container.snp.centerY).offset(-4)
        }

        statValue.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(container.snp.centerY).offset(4)
            make.bottom.equalToSuperview().inset(16)
        }
    }

    private func setUpStyle() {
        container.backgroundColor = .viewBackground
        container.layer.cornerRadius = 16

        statName.textAlignment = .center
        statName.numberOfLines = 0
        statName.font = UIFont.preferredFont(forTextStyle: .subheadline)

        statValue.textAlignment = .center
        statValue.font = UIFont.preferredFont(forTextStyle: .largeTitle)
    }

    func configure(model: StatViewModel) {
        statName.text = model.name
        statValue.text = String(model.baseValue)
    }
}

extension StatCellView {
    static var statRegistration: UICollectionView.CellRegistration<StatCellView, StatViewModel> {
        return .init { cell, _, model in
            cell.configure(model: model)
        }
    }
}
