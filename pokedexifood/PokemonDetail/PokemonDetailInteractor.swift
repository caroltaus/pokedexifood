//
//  PokemonDetailInteractor.swift
//  pokedexifood
//
//  Created by Caroline Taus on 27/03/25.
//

protocol PokemonDetailInteractorProtocol: AnyObject {
    func loadData() async
}

final class PokemonDetailInteractor: PokemonDetailInteractorProtocol {
    private let dataFetcher: PokemonDetailDataFetcherProtocol
    private let presenter: PokemonDetailPresenterProtocol
    private var state: PokemonDetailState
    
    init(
        dataFetcher: PokemonDetailDataFetcherProtocol,
        presenter: PokemonDetailPresenterProtocol,
        initialState: PokemonDetailState
    ) {
        self.dataFetcher = dataFetcher
        self.presenter = presenter
        self.state = initialState
    }
    
    func loadData() async {
        do {
            await presenter.presentLoading()
            
            let response = try await dataFetcher.getPokemonDetail(id: state.id)
            state.pokemon = response
            
            await presenter.dismissLoading()
            await presenter.presentData(pokemon: response)
        } catch {
            await presenter.presentError()
        }

    }
}
