//
//  NetworkSpy.swift
//  pokedexifood
//
//  Created by Caroline Taus on 30/03/25.
//
import Foundation
@testable import pokedexifood

final class NetworkSpy: NetworkProtocol {
    var dataToBeReturned: [URL: Data] = [:]

    func fetch(for url: URL) async throws -> Data {
        guard let dataToBeReturned = dataToBeReturned[url] else {
            throw URLError(.badURL)
        }
        return dataToBeReturned
    }
    func fetch<T>(for url: URL, decodeTo type: T.Type, decoder: JSONDecoder) async throws -> T where T: Decodable {
        guard let dataToBeReturned = dataToBeReturned[url] else {
            throw URLError(.badURL)
        }
        return try decoder.decode(type, from: dataToBeReturned)
    }
}
