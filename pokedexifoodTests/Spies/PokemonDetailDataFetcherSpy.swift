//
//  PokemonDetailDataFetcherSpy.swift
//  pokedexifood
//
//  Created by Caroline Taus on 30/03/25.
//
import Foundation
@testable import pokedexifood

final actor PokemonDetailDataFetcherSpy: PokemonDetailDataFetcherProtocol {
    private(set) var methods: [Method] = []
    enum Method: Equatable {
        case getPokemonDetail
    }

    var getPokemonDetailReturn: Pokemon?
    func getPokemonDetail(id: Int) async throws -> pokedexifood.Pokemon {
        methods.append(.getPokemonDetail)
        guard let getPokemonDetailReturn else { throw URLError(.badURL) }
        return getPokemonDetailReturn
    }

    func setPokemonDetailReturn(_ pokemon: Pokemon?) {
        getPokemonDetailReturn = pokemon
    }
}
