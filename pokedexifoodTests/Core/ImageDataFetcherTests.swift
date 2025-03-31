//
//  ImageDataFetcherTests.swift
//  pokedexifood
//
//  Created by Caroline Taus on 30/03/25.
//

import XCTest
@testable import pokedexifood

final class ImageDataFetcherTests: XCTestCase {
    var sut: ImageDataFetcher!
    var networkSpy: NetworkSpy!

    override func setUp() {
        networkSpy = .init()
        sut = .init(session: networkSpy)
    }

    func testImageRequestFromNetwork() async throws {
        let dataToBeReturned = UIImage(systemName: "plus")
        let url = try XCTUnwrap(URL(string: "https://www.example.com.br"))

        networkSpy.dataToBeReturned[url] = dataToBeReturned?.pngData()

        let result = await sut.requestImage(url: url)

        XCTAssertNotNil(result)
    }

    func testImageRequestFromCache() async throws {
        // setup cache
        let dataToBeReturned = UIImage(systemName: "plus")
        let url = try XCTUnwrap(URL(string: "https://www.example.com.br"))

        networkSpy.dataToBeReturned[url] = dataToBeReturned?.pngData()

        _ = await sut.requestImage(url: url)

        networkSpy.dataToBeReturned[url] = nil

        let result = await sut.requestImage(url: url)

        XCTAssertNotNil(result)
    }
}
