//
//  PokemonListCellViewModel.swift
//  pokedexifood
//
//  Created by Caroline Taus on 26/03/25.
//
import Foundation

struct PokemonListCellViewModel: Hashable {
    let name: String
    let type: String
    let image: URL?
    let id: Int
}
