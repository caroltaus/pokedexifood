//
//  PokemoinDetailInteractorTests.swift
//  pokedexifoodTests
//
//  Created by Caroline Taus on 30/03/25.
//

import XCTest
@testable import pokedexifood

@MainActor
final class PokemonDetailInteractorTests: XCTestCase {
    var sut: PokemonDetailInteractor!
    var dataFetcherSpy: PokemonDetailDataFetcherSpy!
    var presenterSpy: PokemonDetailPresenterSpy!

    override func setUp() {
        dataFetcherSpy = .init()
        presenterSpy = .init()
        sut = .init(
            dataFetcher: dataFetcherSpy,
            presenter: presenterSpy,
            initialState: .init(id: 1)
        )
    }

    override func tearDown() {
        sut = nil
        dataFetcherSpy = nil
        presenterSpy = nil
    }

    /**
     GIVEN an interactor
     WHEN it calls loadData() and it succeeds
     THEN it should call presentLoading(), dismissLoading(), and presentData() in the presenter
     */
    func testLoadDataSuccess() async throws {
        await dataFetcherSpy.setPokemonDetailReturn(
            .init(
                id: 1,
                name: "pokename",
                sprite: .init(image: nil, sprite: nil),
                types: [],
                stats: [],
                moves: []
            )
        )

        await sut.loadData()

        XCTAssertEqual(presenterSpy.methods, [.presentLoading, .dismissLoading, .presentData])
    }

    /**
     GIVEN an interactor
     WHEN it calls loadData() and it fails
     THEN it should call presentLoading(), dismissLoading(), and , presentError() in the presenter
     */
    func testLoadDataError() async throws {
        await dataFetcherSpy.setPokemonDetailReturn(nil)
        await sut.loadData()

        XCTAssertEqual(presenterSpy.methods, [.presentLoading, .dismissLoading, .presentError])
    }

}
