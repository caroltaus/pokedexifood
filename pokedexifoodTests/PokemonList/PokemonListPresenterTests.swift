//
//  PokemonListPresenterTests.swift
//  pokedexifoodTests
//
//  Created by Caroline Taus on 30/03/25.
//

import XCTest
@testable import pokedexifood

@MainActor
final class PokemonListPresenterTests: XCTestCase {
    var sut: PokemonListPresenter!
    var viewControllerSpy: PokemonListViewControllerSpy!

    override func setUp() {
        viewControllerSpy = .init()
        sut = .init()
        sut.viewController = viewControllerSpy
    }

    /**
     GIVEN a presenter with pokemon data and nextUrl
     WHEN it calls presentData()
     THEN it should call displayData() and updateShouldLoadMore(true) in the viewController
     */
    func testPresentDataWithData() {
        sut.presentData(
            state: .init(
                pokemons: [.init(
                    id: 1,
                    name: "pokename",
                    sprite: .init(image: URL(string: "https://example.com"), sprite: nil),
                    types: [.init(type: .init(name: .bug))],
                    stats: [.init(baseStat: 20, statName: .init(name: "attack"))],
                    moves: [.init(move: .init(name: "punch"))]
                )],
                next: URL(string: "https://example.com")
            )
        )

        let expectedDisplayData = PokemonListViewControllerSpy.Method.displayData(
            viewModels: [.init(
                name: "Pokename",
                type: "Bug",
                image: nil,
                id: 1
            )]
        )

        XCTAssertEqual(viewControllerSpy.methods, [expectedDisplayData, .updateShouldLoadMore(true)])
    }

    /**
     GIVEN a presenter without pokemon data and without nextUrl
     WHEN it calls presentData()
     THEN it should call displayData() and updateShouldLoadMore(false) in the viewController
     */
    func testPresentDataWithoutData() {
        sut.presentData(
            state: .init(
                pokemons: [],
                next: nil
            )
        )

        XCTAssertEqual(viewControllerSpy.methods, [.displayData(viewModels: []), .updateShouldLoadMore(false)])
    }

    /**
     GIVEN a presenter
     WHEN it calls presentLoading()
     THEN it should call displayLoadingScreen(true)
     */
    func testPresentLoading() {
        sut.presentLoading()
        XCTAssertEqual(viewControllerSpy.methods, [.displayLoadingScreen(true)])

    }

    /**
     GIVEN a presenter
     WHEN it calls dismissLoading()
     THEN it should call displayLoadingScreen(false)
     */
    func testDismissLoading() {
        sut.dismissLoading()
        XCTAssertEqual(viewControllerSpy.methods, [.displayLoadingScreen(false)])

    }

    /**
     GIVEN a presenter
     WHEN it calls presentError()
     THEN it should call displayErrorAlert
     */
    func testPresentError() {
        sut.presentError()
        XCTAssertEqual(viewControllerSpy.methods, [.displayErrorAlert])

    }
}
