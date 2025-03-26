//
//  PokemonListPresenter.swift
//  pokedex
//
//  Created by Caroline Taus on 25/03/25.
//

protocol PokemonListPresenterProtocol: AnyObject {
    func presentData(pokemons: [Pokemon])
    func presentLoading()
    func dismissLoading()
    func presentError()
}

final class PokemonListPresenter: PokemonListPresenterProtocol {
    weak var viewController: PokemonListViewControllerProtocol?

    func presentData(pokemons: [Pokemon]) {
        //
    }
    
    func presentLoading() {
        //
    }
    
    func dismissLoading() {
        
    }
    
    func presentError() {
        //
    }
    
    
}
