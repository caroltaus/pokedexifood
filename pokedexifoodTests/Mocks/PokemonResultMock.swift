//
//  PokemonResultMock.swift
//  pokedexifood
//
//  Created by Caroline Taus on 30/03/25.
//
// swiftlint:disable:next blanket_disable_command
// swiftlint:disable non_optional_string_data_conversion

import Foundation
@testable import pokedexifood

extension PokemonResponse {
    static var mockData: Data? {
        """
        {
          "count": 1302,
          "next": "https://pokeapi.co/api/v2/pokemon?offset=1&limit=1",
          "previous": null,
          "results": [
            {
              "name": "bulbasaur",
              "url": "https://pokeapi.co/api/v2/pokemon/1/"
            }
          ]
        }
        """.data(using: .utf8)
    }
}
