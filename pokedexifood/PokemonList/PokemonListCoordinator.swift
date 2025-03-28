//
//  PokemonListCoordinator.swift
//  pokedexifood
//
//  Created by Caroline Taus on 27/03/25.
//
import UIKit

@MainActor
protocol PokemonListCoordinatorProtocol: AnyObject {
    func goToPokemonDetail(id: Int)
    func showErrorAlert(
        title: String,
        message: String,
        buttonTitle: String,
        onButtonTap: @escaping() -> Void
    )
}

final class PokemonListCoordinator: PokemonListCoordinatorProtocol {
    weak var viewController: UIViewController?
    private let detailFactory: PokemonDetailFactoryProtocol
    
    init(
        viewController: UIViewController? = nil,
        detailFactory: PokemonDetailFactoryProtocol
    ) {
        self.viewController = viewController
        self.detailFactory = detailFactory
    }
    
    func goToPokemonDetail(id: Int) {
        let detailViewController = detailFactory.build(id: id)
        viewController?.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func showErrorAlert(
        title: String,
        message: String,
        buttonTitle: String,
        onButtonTap: @escaping () -> Void
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: buttonTitle, style: .default, handler: { _ in
            onButtonTap()
        }))
        viewController?.present(alert, animated: true, completion: nil)
    }
}
