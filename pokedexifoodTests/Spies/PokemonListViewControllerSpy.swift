//
//  PokemonListViewControllerSpy.swift
//  pokedexifood
//
//  Created by Caroline Taus on 30/03/25.
//
@testable import pokedexifood

final class PokemonListViewControllerSpy: PokemonListViewControllerProtocol {
    private(set) var methods: [Method] = []

    enum Method: Equatable {
        case displayData(viewModels: [PokemonListCellViewModel])
        case updateShouldLoadMore(Bool)
        case displayLoadingScreen(Bool)
        case displayErrorAlert
    }

    func displayData(viewModels: [pokedexifood.PokemonListCellViewModel]) {
        methods.append(.displayData(viewModels: viewModels))
    }

    func updateShouldLoadMore(value: Bool) {
        methods.append(.updateShouldLoadMore(value))
    }

    func displayLoadingScreen(value: Bool) {
        methods.append(.displayLoadingScreen(value))
    }

    func displayErrorAlert(title: String, message: String, buttonTitle: String) {
        methods.append(.displayErrorAlert)
    }
}
