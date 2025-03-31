//
//  PokemonListFactoryTests.swift
//  pokedexifoodTests
//
//  Created by Caroline Taus on 30/03/25.
//

import XCTest
@testable import pokedexifood

@MainActor
final class PokemonListFactoryTests: XCTestCase {
    var sut: PokemonListFactory!

    override func setUp() {
        sut = .init()
    }

    func testBuild() {
        let result = sut.build()

        XCTAssertTrue(result is PokemonListViewController)
    }
}
