//
//  PokemonDetailInteractor.swift
//  pokedexifood
//
//  Created by Caroline Taus on 27/03/25.
//

protocol PokemonDetailInteractorProtocol: AnyObject {
    func loadData() async
    func tryAgain() async
    
}

final class PokemonDetailInteractor: PokemonListInteractorProtocol {
    func loadData() async {
        //
    }
    
    func tryAgain() async {
        //
    }
    
}
