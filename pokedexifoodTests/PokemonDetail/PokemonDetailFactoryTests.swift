//
//  PokemonDetailFactoryTests.swift
//  pokedexifoodTests
//
//  Created by Caroline Taus on 30/03/25.
//

import XCTest
@testable import pokedexifood

@MainActor
final class PokemonDetailFactoryTests: XCTestCase {
    var sut: PokemonDetailFactory!

    override func setUp() {
        sut = .init()
    }

    func testBuild() {
        let result = sut.build(id: 1)

        XCTAssertTrue(result is PokemonDetailViewController)
    }
}
