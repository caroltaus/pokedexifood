//
//  SectionTitleView.swift
//  pokedexifood
//
//  Created by Caroline Taus on 29/03/25.
//

import UIKit
import SnapKit

final class SectionTitleView: UICollectionReusableView {
    lazy var container: UIView = {
        return UIView()
    }()

    private lazy var label: UILabel = {
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
        self.addSubview(container)
        container.addSubview(label)
    }

    private func setUpConstraint() {
        container.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.top.equalToSuperview().inset(16)
        }

        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setUpStyle() {
        label.textColor = .secondaryLabel
        label.font = UIFont.preferredFont(forTextStyle: .headline)
    }

    func configure(title: String) {
        label.text = title
    }

}
