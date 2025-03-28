//
//  PokemonListInteractor.swift
//  pokedex
//
//  Created by Caroline Taus on 25/03/25.
//
import Foundation

protocol PokemonListInteractorProtocol: AnyObject {
    func loadData() async
    func tryAgain() async
    
}

final class PokemonListInteractor: PokemonListInteractorProtocol {
    private let dataFetcher: PokemonListDataFetcherProtocol
    private var state: PokemonListState
    private let presenter: PokemonListPresenterProtocol
    
    init(
        dataFetcher: PokemonListDataFetcherProtocol,
        state: PokemonListState = .init(),
        presenter: PokemonListPresenterProtocol
    ) {
        self.dataFetcher = dataFetcher
        self.state = state
        self.presenter = presenter
    }
    
    func loadData() async {
        do {
            await presenter.presentLoading()
            
            let response = try await dataFetcher.getPokemonList(url: state.next)
            state.pokemons += response.pokemons
            state.next = response.next
            
            await presenter.dismissLoading()
            await presenter.presentData(state: state)
        } catch {
            await presenter.presentError()
        }
    }
    
    func tryAgain() async {
        print("bateu no int")
        state = .init()
        await loadData()
    }
}


