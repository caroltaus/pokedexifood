//
//  PokemonListDataFetcher.swift
//  pokedex
//
//  Created by Caroline Taus on 25/03/25.
//
import Foundation

protocol PokemonListDataFetcherProtocol: Actor {
    func getPokemonList(url: URL?) async throws -> PokemonResponse
}

final actor PokemonListDataFetcher: PokemonListDataFetcherProtocol {
    private let session: NetworkProtocol

    init(session: NetworkProtocol = URLSession.shared) {
        self.session = session
    }

    func getPokemonList(url: URL?) async throws -> PokemonResponse {
        guard let url = url ?? pokemonURL() else {
            throw URLError.init(.badURL)
        }
        // get da lista geral
        let decodedList = try await session.fetch(for: url, decodeTo: PokemonList.self)

        // get de cada pokemon
        var pokemons: [Pokemon] = []
        for pokemon in decodedList.results {
            let decodedPokemon = try await session.fetch(for: pokemon.url, decodeTo: Pokemon.self)
            pokemons.append(decodedPokemon)
        }

        return PokemonResponse(pokemons: pokemons, next: decodedList.next)
    }

    private func pokemonURL() -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "pokeapi.co"
        components.path = "/api/v2/pokemon"

        return components.url
    }
}
