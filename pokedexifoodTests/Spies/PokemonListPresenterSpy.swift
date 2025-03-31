//
//  PokemonListPresenterSpy.swift
//  pokedexifood
//
//  Created by Caroline Taus on 30/03/25.
//
@testable import pokedexifood

final class PokemonListPresenterSpy: PokemonListPresenterProtocol {
    private(set) var methods: [Method] = []
    enum Method: Equatable {
        case presentData
        case presentLoading
        case dismissLoading
        case presentError
    }

    func presentData(state: pokedexifood.PokemonListState) {
        methods.append(.presentData)
    }

    func presentLoading() {
        methods.append(.presentLoading)
    }

    func dismissLoading() {
        methods.append(.dismissLoading)
    }

    func presentError() {
        methods.append(.presentError)
    }
}
