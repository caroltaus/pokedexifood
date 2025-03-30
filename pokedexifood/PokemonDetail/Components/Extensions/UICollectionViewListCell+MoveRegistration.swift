//
//  UICollectionViewListCell+MoveRegistration.swift
//  pokedexifood
//
//  Created by Caroline Taus on 29/03/25.
//
import UIKit

extension UICollectionViewListCell {
    static var moveRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, String> {
        return .init { cell, _, moveName in
            var contentConfiguration = UIListContentConfiguration.cell()
            contentConfiguration.text = moveName
            cell.contentConfiguration = contentConfiguration
        }
    }
}
