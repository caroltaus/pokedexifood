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

final actor PokemonListDataFetcher: PokemonListDataFetcherProtocol  {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getPokemonList(url: URL?) async throws -> PokemonResponse {
        guard let url = url ?? pokemonURL() else {
            throw URLError.init(.badURL)
        }
        // get da lista geral
        let decodedList = try await fetch(for: url, decodeTo: PokemonList.self)
        
        // get de cada pokemon
        var pokemons: [Pokemon] = []
        for pokemon in decodedList.results {
            let decodedPokemon = try await fetch(for: pokemon.url, decodeTo: Pokemon.self)
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
    
    private func fetch<T: Decodable>(
        for url: URL,
        decodeTo type: T.Type,
        decoder: JSONDecoder = JSONDecoder()
    ) async throws -> T {
        let (data, _) = try await session.data(from: url)
        return try decoder.decode(type, from: data)
    }
    
}
