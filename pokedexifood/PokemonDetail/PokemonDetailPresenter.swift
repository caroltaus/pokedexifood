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
        viewController?.displayPokemonName(name: pokemon.name.capitalized)
        let coverSection = await createCoverSection(url: pokemon.sprite.image)
        let pokemonTypesSection = createPokemonTypesSection(types: pokemon.types)
        let statsSection = createStatsSection(stats: pokemon.stats)
        let movesSection = createMovesSection(moves: pokemon.moves)

        viewController?.displayData(sections: [coverSection, pokemonTypesSection, statsSection, movesSection])
    }

    func presentLoading() {
        viewController?.displayLoadingScreen(value: true)
    }

    func dismissLoading() {
        viewController?.displayLoadingScreen(value: false)
    }

    func presentError() {
        viewController?.displayErrorAlert(
            title: "Erro",
            message: "Sua requisição falhou",
            buttonTitle: "Tentar Novamente"
        )
    }

    private func createCoverSection(url: URL?) async -> PokemonDetailSection {
        guard let url = url else {
            // IMAGEM DE ERRO DE IMAGEM
            return PokemonDetailSection(section: .cover, items: [])
        }
        let image = await imageDataFetcher.requestImage(url: url) ?? UIImage() // TROCAR PRA IMG D EERRO
        return PokemonDetailSection(section: .cover, items: [.picture(image: image)])
    }

    private func createPokemonTypesSection(types: [Pokemon.PokemonType]) -> PokemonDetailSection {
        let poketypes = types.map {
            // MUDAR PRA COLOR CERTA
            let viewModel = PoketypeViewModel(typeName: $0.type.name.capitalized, typeColor: .red)
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
