//
//  ImageDataFetcherSpy.swift
//  pokedexifood
//
//  Created by Caroline Taus on 30/03/25.
//
import UIKit
@testable import pokedexifood

final actor ImageDataFetcherSpy: ImageDataFetcherProtocol {
    private(set) var methods: [Method] = []

    enum Method: Equatable {
        case requestImage
    }

    var getPokemonImageReturn: UIImage?

    func requestImage(url: URL) async -> UIImage? {
        methods.append(.requestImage)
        return getPokemonImageReturn
    }

    func setPokemonImageReturn(_ image: UIImage?) {
        getPokemonImageReturn = image
    }
}
