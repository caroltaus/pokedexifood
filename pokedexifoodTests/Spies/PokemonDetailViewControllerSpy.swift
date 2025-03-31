//
//  PokemonDetailViewControllerSpy.swift
//  pokedexifood
//
//  Created by Caroline Taus on 30/03/25.
//
@testable import pokedexifood

final class PokemonDetailViewControllerSpy: PokemonDetailViewControllerProtocol {
    private(set) var methods: [Method] = []

    enum Method: Equatable {
        case displayData(sections: [PokemonDetailSection])
        case displayLoadingScreen(value: Bool)
        case displayErrorAlert
        case displayPokemonName
    }

    func displayData(sections: [pokedexifood.PokemonDetailSection]) {
        methods.append(.displayData(sections: sections))
    }

    func displayLoadingScreen(value: Bool) {
        methods.append(.displayLoadingScreen(value: value))
    }

    func displayErrorAlert(title: String, message: String, buttonTitle: String) {
        methods.append(.displayErrorAlert)
    }

    func displayPokemonName(name: String) {
        methods.append(.displayPokemonName)
    }
}
