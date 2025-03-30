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
                .gray
        case .fire:
                .red
        case .fighting:
                .orange
        case .water:
                .blue
        case .flying:
                .cyan
        case .grass:
                .green
        case .poison:
                .purple
        case .electric:
                .yellow
        case .ground:
                .brown
        case .psychic:
                .systemPink
        case .rock:
                .darkGray
        case .ice:
                .blue
        case .bug:
                .systemGreen
        case .dragon:
                .blue
        case .ghost:
                .systemPurple
        case .dark:
                .black
        case .steel:
                .blue
        case .fairy:
                .systemPink
        }
    }
}
