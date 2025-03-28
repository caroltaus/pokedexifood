//
//  PokemonListPresenter.swift
//  pokedex
//
//  Created by Caroline Taus on 25/03/25.
//

@MainActor
protocol PokemonListPresenterProtocol: AnyObject {
    func presentData(state: PokemonListState)
    func presentLoading()
    func dismissLoading()
    func presentError()
}

final class PokemonListPresenter: PokemonListPresenterProtocol {
    weak var viewController: PokemonListViewControllerProtocol?

    func presentData(state: PokemonListState) {
        let viewModels = state.pokemons.map { pokemon in
            let type = pokemon.types.map {
                $0.type.name.capitalized
            }
            .joined(separator: " / ")
            
            return PokemonListCellViewModel(name: pokemon.name.capitalized, type: type, image: pokemon.sprite.spriteUrl)
        }
        viewController?.displayData(viewModels: viewModels)
        viewController?.updateShouldLoadMore(value: state.next != nil)
    }
    
    func presentLoading() {
        viewController?.displayLoadingScreen(value: true)
    }
    
    func dismissLoading() {
        viewController?.displayLoadingScreen(value: false)
    }
    
    func presentError() {
        viewController?.displayErrorAlert(title: "titulo erro", message: "msg erro", buttonTitle: "tentar d enovo")
    }
    
    
}
