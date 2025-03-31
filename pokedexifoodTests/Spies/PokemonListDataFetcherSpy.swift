//
//  PokemonListDataFetcherSpy.swift
//  pokedexifood
//
//  Created by Caroline Taus on 30/03/25.
//
import Foundation
@testable import pokedexifood

final actor PokemonListDataFetcherSpy: PokemonListDataFetcherProtocol {
    private(set) var methods: [Method] = []
    enum Method: Equatable {
        case getPokemonList
    }

    var getPokemonListReturn: PokemonResponse?
    func getPokemonList(url: URL?) async throws -> pokedexifood.PokemonResponse {
        methods.append(.getPokemonList)
        guard let getPokemonListReturn else {throw URLError(.badURL) }
        return getPokemonListReturn
    }

    func setPokemonListReturn(_ pokemonList: PokemonResponse?) {
        getPokemonListReturn = pokemonList
    }
}
