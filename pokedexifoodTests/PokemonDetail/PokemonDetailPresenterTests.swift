//
//  PokemonDetailPresenterTests.swift
//  pokedexifoodTests
//
//  Created by Caroline Taus on 30/03/25.
//

import XCTest
@testable import pokedexifood

@MainActor
final class PokemonDetailPresenterTests: XCTestCase {
    var sut: PokemonDetailPresenter!
    var imageDataFetcherSpy: ImageDataFetcherSpy!
    var viewControllerSpy: PokemonDetailViewControllerSpy!

    override func setUp() {
        imageDataFetcherSpy = .init()
        viewControllerSpy = .init()
        sut = .init(imageDataFetcher: imageDataFetcherSpy)

        sut.viewController = viewControllerSpy
    }

    override func tearDown() {
        sut = nil
        imageDataFetcherSpy = nil
        viewControllerSpy = nil
    }

    /**
     GIVEN a presenter
     WHEN it calls presentData() with an image url
     THEN it should call displayPokemonName() and displayData() in the viewController
     */
    func testPresentDataWithImageSuccess() async throws {
        let image = UIImage(systemName: "plus")
        await imageDataFetcherSpy.setPokemonImageReturn(image)
        await sut.presentData(
            pokemon: .init(
                id: 1,
                name: "pokename",
                sprite: .init(image: URL(string: "https://example.com"), sprite: nil),
                types: [.init(type: .init(name: .bug))],
                stats: [.init(baseStat: 20, statName: .init(name: "attack"))],
                moves: [.init(move: .init(name: "punch"))]
            )
        )

        let expectedDisplayData = PokemonDetailViewControllerSpy.Method.displayData(sections: [
            .init(section: .cover, items: [.picture(image: try XCTUnwrap(image))]),
            .init(section: .pokemonTypes, items: [.poketype(.init(typeName: "Bug", typeColor: .bug))]),
            .init(section: .stats, items: [.stat(.init(name: "Attack", baseValue: 20))]),
            .init(section: .moves, items: [.move("Punch")])
        ])
        XCTAssertEqual(viewControllerSpy.methods, [.displayPokemonName, expectedDisplayData])
    }

    /**
     GIVEN a presenter
     WHEN it calls presentData() without an image url
     THEN it should call displayPokemonName() and displayData() in the viewController
     */
    func testPresentDataWithoutImageUrl() async throws {
        await sut.presentData(
            pokemon: .init(
                id: 1,
                name: "pokename",
                sprite: .init(image: nil, sprite: nil),
                types: [],
                stats: [],
                moves: []
            )
        )

        XCTAssertEqual(
            viewControllerSpy.methods,
            [
                .displayPokemonName,
                .displayData(
                    sections: [.init(
                        section: .cover,
                        items: [.picture(image: UIImage(resource: .pokemonNotFound))]
                    )]
                )
            ]
        )
    }

    /**
     GIVEN a presenter
     WHEN it calls presentLoading()
     THEN it should call displayLoadingScreen(true) in the viewController
     */
    func testPresentLoading() async {
        sut.presentLoading()
        XCTAssertEqual(viewControllerSpy.methods, [.displayLoadingScreen(value: true)])
    }

    /**
     GIVEN a presenter
     WHEN it calls dismissLoading()
     THEN it should call displayLoadingScreen(false) in the viewController
     */
    func testDismissLoading() async {
        sut.dismissLoading()
        XCTAssertEqual(viewControllerSpy.methods, [.displayLoadingScreen(value: false)])
    }

    /**
     GIVEN a presenter
     WHEN it calls presentError()
     THEN it should call displayErrorAlert in the viewController
     */
    func testPresentError() async {
        sut.presentError()
        XCTAssertEqual(viewControllerSpy.methods, [.displayErrorAlert])
    }
}
