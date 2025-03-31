//
//  PokemonListInteractorTests.swift
//  pokedexifoodTests
//
//  Created by Caroline Taus on 30/03/25.
//

import XCTest
@testable import pokedexifood

@MainActor
final class PokemonListInteractorTests: XCTestCase {
    var sut: PokemonListInteractor!
    var dataFetcherSpy: PokemonListDataFetcherSpy!
    var presenterSpy: PokemonListPresenterSpy!

    override func setUp() {
        dataFetcherSpy = .init()
        presenterSpy = .init()
        sut = .init(
            dataFetcher: dataFetcherSpy,
            presenter: presenterSpy
        )
    }

    /**
     GIVEN an interactor
     WHEN it calls loadData() and it succeeds
     THEN it should call presentLoading(), dismissLoading(), and presentData() in the presenter
     */
    func testLoadDataSuccess() async {
        await dataFetcherSpy.setPokemonListReturn(
            .init(
                pokemons: [.init(
                    id: 1,
                    name: "",
                    sprite: .init(image: nil, sprite: nil),
                    types: [],
                    stats: [],
                    moves: []
                )],
                next: nil
            )
        )
        await sut.loadData()
        XCTAssertEqual(presenterSpy.methods, [.presentLoading, .dismissLoading, .presentData])
    }

    /**
     GIVEN an interactor
     WHEN it calls loadData() and it fails
     THEN it should call presentLoading(), dismissLoading(), and presentError() in the presenter
     */
    func testLoadDataFail() async {
        await dataFetcherSpy.setPokemonListReturn(nil)
        await sut.loadData()
        XCTAssertEqual(presenterSpy.methods, [.presentLoading, .dismissLoading, .presentError])
    }

    /**
     GIVEN an interactor
     WHEN it calls tryAgain() and it succeeds
     THEN it should call presentLoading(), dismissLoading(), and presentData() in the presenter
     */
    func testTryAgainSuccess() async {
        await dataFetcherSpy.setPokemonListReturn(
            .init(
                pokemons: [.init(
                    id: 1,
                    name: "",
                    sprite: .init(image: nil, sprite: nil),
                    types: [],
                    stats: [],
                    moves: []
                )],
                next: nil
            )
        )
        await sut.tryAgain()
        XCTAssertEqual(presenterSpy.methods, [.presentLoading, .dismissLoading, .presentData])
    }

    /**
     GIVEN an interactor
     WHEN it calls tryAgain() and it fails
     THEN it should call presentLoading(), dismissLoading(), and presentError() in the presenter
     */
    func testTryAgainFail() async {
        await dataFetcherSpy.setPokemonListReturn(nil)
        await sut.tryAgain()
        XCTAssertEqual(presenterSpy.methods, [.presentLoading, .dismissLoading, .presentError])
    }
}
