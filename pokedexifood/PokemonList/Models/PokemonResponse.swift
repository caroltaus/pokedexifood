//
//  PokemonResponse.swift
//  pokedex
//
//  Created by Caroline Taus on 25/03/25.
//
import Foundation

struct PokemonResponse: Equatable {
    let pokemons: [Pokemon]
    let next: URL?
}
