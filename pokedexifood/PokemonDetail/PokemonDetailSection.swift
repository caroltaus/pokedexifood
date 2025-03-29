//
//  PokemonDetailSection.swift
//  pokedexifood
//
//  Created by Caroline Taus on 29/03/25.
//
import UIKit

struct PokemonDetailSection: Equatable, Hashable {
    let section: SectionType
    let items: [Item]
}

enum SectionType: Hashable, Equatable {
    case cover
    case pokemonTypes
    case stats
    case moves
}

enum Item: Hashable, Equatable {
    case picture(image: UIImage)
    case poketype(PoketypeViewModel)
    case stat(StatViewModel)
    case move(String)
}
