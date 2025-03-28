//
//  PokemonDetailPresenter.swift
//  pokedexifood
//
//  Created by Caroline Taus on 27/03/25.
//

protocol PokemonDetailPresenterProtocol: AnyObject {
    
}

final class PokemonDetailPresenter: PokemonDetailPresenterProtocol {
    weak var viewController: PokemonDetailViewControllerProtocol?
    
}
