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
        let interactor = PokemonListInteractor(dataFetcher: dataFetcher, presenter: presenter)
        let viewController = PokemonListViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
