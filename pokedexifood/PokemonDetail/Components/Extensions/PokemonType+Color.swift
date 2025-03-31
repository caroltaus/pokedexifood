//
//  PokemonType+Color.swift
//  pokedexifood
//
//  Created by Caroline Taus on 29/03/25.
//
import UIKit

extension Pokemon.PokemonType {
    var color: UIColor {
        switch self {
        case .normal:
                .normal
        case .fire:
                .fire
        case .fighting:
                .fighting
        case .water:
                .water
        case .flying:
                .flying
        case .grass:
                .grass
        case .poison:
                .poison
        case .electric:
                .eletric
        case .ground:
                .ground
        case .psychic:
                .psychic
        case .rock:
                .rock
        case .ice:
                .ice
        case .bug:
                .bug
        case .dragon:
                .dragon
        case .ghost:
                .ghost
        case .dark:
                .dark
        case .steel:
                .steel
        case .fairy:
                .fairy
        }
    }
}
