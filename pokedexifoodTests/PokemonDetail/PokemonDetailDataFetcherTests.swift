//
//  PokemonDetailDataFetcherTests.swift
//  pokedexifoodTests
//
//  Created by Caroline Taus on 30/03/25.
//

import XCTest
@testable import pokedexifood

final class PokemonDetailDataFetcherTests: XCTestCase {

    var sut: PokemonDetailDataFetcher!
    var networkSpy: NetworkSpy!

    override func setUp() {
        networkSpy = .init()
        sut = .init(session: networkSpy)
    }

    /**
     GIVEN an dataFetcher
     WHEN it calls getPokemonDetail() and it succeeds
     THEN it should return a Pokemon
     */
    func testGetPokemonDetail() async throws {
        let url = try XCTUnwrap(URL(string: "https://pokeapi.co/api/v2/pokemon/1"))
        networkSpy.dataToBeReturned[url] = Pokemon.mockData
        let result = try await sut.getPokemonDetail(id: 1)

        let expectedResult = try JSONDecoder().decode(Pokemon.self, from: try XCTUnwrap(Pokemon.mockData))

        XCTAssertEqual(result, expectedResult)
    }
}
