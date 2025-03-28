//
//  PokemonListFactory.swift
//  pokedex
//
//  Created by Caroline Taus on 25/03/25.
//
import UIKit

@MainActor
protocol PokemonListFactoryProtocol {
    func build() -> UIViewController
}

final class PokemonListFactory: PokemonListFactoryProtocol {
    func build() -> UIViewController {
        let presenter = PokemonListPresenter()
        let dataFetcher = PokemonListDataFetcher()
        let coordinator = PokemonListCoordinator(detailFactory: PokemonDetailFactory())
        let interactor = PokemonListInteractor(dataFetcher: dataFetcher, presenter: presenter)
        let viewController = PokemonListViewController(interactor: interactor, coordinator: coordinator)
        coordinator.viewController = viewController
        presenter.viewController = viewController
        return viewController
    }
}
