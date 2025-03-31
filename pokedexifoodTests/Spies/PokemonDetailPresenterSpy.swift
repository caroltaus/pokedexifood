//
//  PokemonDetailPresenterSpy.swift
//  pokedexifood
//
//  Created by Caroline Taus on 30/03/25.
//
@testable import pokedexifood

final class PokemonDetailPresenterSpy: PokemonDetailPresenterProtocol {
    private(set) var methods: [Method] = []

    enum Method: Equatable {
        case presentLoading
        case dismissLoading
        case presentData
        case presentError
    }

    func presentLoading() {
        methods.append(.presentLoading)
    }

    func dismissLoading() {
        methods.append(.dismissLoading)
    }

    func presentData(pokemon: pokedexifood.Pokemon) async {
        methods.append(.presentData)
    }

    func presentError() {
        methods.append(.presentError)
    }
}
