//
//  PokemonList.swift
//  pokedex
//
//  Created by Caroline Taus on 25/03/25.
//
import Foundation

struct PokemonList: Decodable {
    let count: Int // preciso pra algo?
    let next: URL?
    let previous: URL?
    let results: [PokemonResults]
    
    struct PokemonResults: Decodable {
        let name: String
        let url: URL
    }
}
