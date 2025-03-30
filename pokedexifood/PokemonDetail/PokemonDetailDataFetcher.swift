//
//  PokemonDetailDataFetcher.swift
//  pokedexifood
//
//  Created by Caroline Taus on 27/03/25.
//
import Foundation

protocol PokemonDetailDataFetcherProtocol: Actor {
    func getPokemonDetail(id: Int) async throws -> Pokemon
}

final actor PokemonDetailDataFetcher: PokemonDetailDataFetcherProtocol {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func getPokemonDetail(id: Int) async throws -> Pokemon {
        guard let url = pokemonDetailURL(id: id) else {
            throw URLError.init(.badURL)
        }

        return try await fetch(for: url, decodeTo: Pokemon.self)
    }

    private func pokemonDetailURL(id: Int) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "pokeapi.co"
        components.path = "/api/v2/pokemon/\(id)"

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
