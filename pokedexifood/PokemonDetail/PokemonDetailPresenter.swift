//
//  PokemonDetailPresenter.swift
//  pokedexifood
//
//  Created by Caroline Taus on 27/03/25.
//
import UIKit

@MainActor
protocol PokemonDetailPresenterProtocol: AnyObject {
    func presentLoading()
    func dismissLoading()
    func presentData(pokemon: Pokemon) async
    func presentError()
}

final class PokemonDetailPresenter: PokemonDetailPresenterProtocol {
    weak var viewController: PokemonDetailViewControllerProtocol?
    private let imageDataFetcher: ImageDataFetcherProtocol

    init(imageDataFetcher: ImageDataFetcherProtocol) {
        self.imageDataFetcher = imageDataFetcher
    }

    func presentData(pokemon: Pokemon) async {
        viewController?.displayPokemonName(name: pokemon.name.replacingOccurrences(of: "-", with: " ").capitalized)
        let coverSection = await createCoverSection(url: pokemon.sprite.image)
        let pokemonTypesSection = createPokemonTypesSection(types: pokemon.types)
        let statsSection = createStatsSection(stats: pokemon.stats)
        let movesSection = createMovesSection(moves: pokemon.moves)

        let sections = [coverSection, pokemonTypesSection, statsSection, movesSection]
        let filteredSections = sections.filter {
            !$0.items.isEmpty
        }

        viewController?.displayData(sections: filteredSections)
    }

    func presentLoading() {
        viewController?.displayLoadingScreen(value: true)
    }

    func dismissLoading() {
        viewController?.displayLoadingScreen(value: false)
    }

    func presentError() {
        viewController?.displayErrorAlert(
            title: "Error",
            message: "Your request has failed",
            buttonTitle: "Try Again"
        )
    }

    private func createCoverSection(url: URL?) async -> PokemonDetailSection {
        guard let url = url else {
            return PokemonDetailSection(section: .cover, items: [.picture(image: UIImage(resource: .pokemonNotFound))])
        }
        let image = await imageDataFetcher.requestImage(url: url) ?? UIImage(resource: .pokemonNotFound)
        return PokemonDetailSection(section: .cover, items: [.picture(image: image)])
    }

    private func createPokemonTypesSection(types: [Pokemon.PokemonTypeData]) -> PokemonDetailSection {
        let poketypes = types.map {
            let viewModel = PoketypeViewModel(
                typeName: $0.type.name.rawValue.capitalized,
                typeColor: $0.type.name.color
            )
            return Item.poketype(viewModel)
        }
        return PokemonDetailSection(section: .pokemonTypes, items: poketypes)
    }

    private func createStatsSection(stats: [Pokemon.PokemonStat]) -> PokemonDetailSection {
        let stats = stats.map {
            let viewModel = StatViewModel(
                name: $0.statName.name.replacingOccurrences(of: "-", with: " ").capitalized,
                baseValue: $0.baseStat
            )
            return Item.stat(viewModel)
        }
        return PokemonDetailSection(section: .stats, items: stats)
    }

    private func createMovesSection(moves: [Pokemon.PokemonMove]) -> PokemonDetailSection {
        let moves = moves.map {
            let moveName = $0.move.name.replacingOccurrences(of: "-", with: " ").capitalized
            return Item.move(moveName)
        }
        return PokemonDetailSection(section: .moves, items: moves)
    }
}
