//
//  PokemonDetailFactory.swift
//  pokedexifood
//
//  Created by Caroline Taus on 27/03/25.
//
import UIKit

@MainActor
protocol PokemonDetailFactoryProtocol: AnyObject {
    func build(id: Int) -> UIViewController
}

final class PokemonDetailFactory: PokemonDetailFactoryProtocol {
    func build(id: Int) -> UIViewController {
        let presenter = PokemonDetailPresenter(imageDataFetcher: ImageDataFetcher.shared)
        let dataFetcher = PokemonDetailDataFetcher()
        let interactor = PokemonDetailInteractor(dataFetcher: dataFetcher, presenter: presenter, initialState: .init(id: id))
        let viewController = PokemonDetailViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
