//
//  PokemonListDataFetcherTests.swift
//  pokedexifoodTests
//
//  Created by Caroline Taus on 30/03/25.
//

import XCTest
@testable import pokedexifood

final class PokemonListDataFetcherTests: XCTestCase {
    var sut: PokemonListDataFetcher!
    var networkSpy: NetworkSpy!

    override func setUp() {
        networkSpy = .init()
        sut = .init(session: networkSpy)
    }

    func testGetPokemonList() async throws {
        let url = try XCTUnwrap(URL(string: "https://example.com"))
        let pokemonUrl = try XCTUnwrap(URL(string: "https://pokeapi.co/api/v2/pokemon/1/"))
        networkSpy.dataToBeReturned[url] = PokemonResponse.mockData
        networkSpy.dataToBeReturned[pokemonUrl] = Pokemon.mockData

        let result = try await sut.getPokemonList(url: url)
        let expectedResult = [
            try JSONDecoder().decode(Pokemon.self, from: try XCTUnwrap(Pokemon.mockData))
        ]

        XCTAssertEqual(result.pokemons, expectedResult)
    }
}
