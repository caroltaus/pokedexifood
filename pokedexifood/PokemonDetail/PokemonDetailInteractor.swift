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

final class PokemonDetailInteractor: PokemonDetailInteractorProtocol {
    private let dataFetcher: PokemonDetailDataFetcherProtocol
    private let presenter: PokemonDetailPresenterProtocol
    
    init(
        dataFetcher: PokemonDetailDataFetcherProtocol,
        presenter: PokemonDetailPresenterProtocol
    ) {
        self.dataFetcher = dataFetcher
        self.presenter = presenter
    }
    
    func loadData() async {
        //
    }
    
    func tryAgain() async {
        //
    }
    
}
