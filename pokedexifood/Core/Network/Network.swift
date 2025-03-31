//
//  Network.swift
//  pokedexifood
//
//  Created by Caroline Taus on 30/03/25.
//
import Foundation

protocol NetworkProtocol {
    func fetch<T: Decodable>(
        for url: URL,
        decodeTo type: T.Type,
        decoder: JSONDecoder
    ) async throws -> T

    func fetch(
        for url: URL
    ) async throws -> Data
}

extension NetworkProtocol {
    func fetch<T: Decodable>(
        for url: URL,
        decodeTo type: T.Type
    ) async throws -> T {
        return try await fetch(for: url, decodeTo: type, decoder: JSONDecoder())
    }
}

extension URLSession: NetworkProtocol {
    func fetch(for url: URL) async throws -> Data {
        let (data, _) = try await self.data(from: url)
        return data
    }

    func fetch<T>(for url: URL, decodeTo type: T.Type, decoder: JSONDecoder) async throws -> T where T: Decodable {
        let (data, _) = try await self.data(from: url)
        return try decoder.decode(type, from: data)
    }
}
