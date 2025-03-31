//
//  Pokemon.swift
//  pokedex
//
//  Created by Caroline Taus on 25/03/25.
//
// swiftlint:disable:next blanket_disable_command
// swiftlint:disable nesting
import Foundation

struct Pokemon: Decodable, Equatable {
    let id: Int
    let name: String
    let sprite: Sprite
    let types: [PokemonTypeData]
    let stats: [PokemonStat]
    let moves: [PokemonMove]

    enum CodingKeys: String, CodingKey {
        case id, name, types, stats, moves
        case sprite = "sprites"
    }

    struct Sprite: Decodable, Equatable {
        let image: URL?
        let spriteUrl: URL?

        enum SpriteCodingKeys: String, CodingKey {
            case other
            case frontDefault = "front_default"
        }

        enum OtherCodingKeys: String, CodingKey {
            case officialArtwork = "official-artwork"
        }

        enum OfficialArtworkCodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }

        init(from decoder: any Decoder) throws {
            let container = try? decoder.container(keyedBy: SpriteCodingKeys.self)
            let otherContainer = try? container?.nestedContainer(keyedBy: OtherCodingKeys.self, forKey: .other)
            let officialArtworkContainer = try? otherContainer?.nestedContainer(
                keyedBy: OfficialArtworkCodingKeys.self,
                forKey: .officialArtwork
            )

            self.image = try? officialArtworkContainer?.decode(URL.self, forKey: .frontDefault)
            self.spriteUrl = try? container?.decode(URL.self, forKey: .frontDefault)
        }

        init(
            image: URL?,
            sprite: URL?
        ) {
            self.image = image
            self.spriteUrl = sprite
        }
    }

    struct PokemonTypeData: Decodable, Equatable {
        let type: TypeName

        struct TypeName: Decodable, Equatable {
            let name: PokemonType
        }
    }

    struct PokemonStat: Decodable, Equatable {
        let baseStat: Int
        let statName: StatName

        enum CodingKeys: String, CodingKey {
            case baseStat = "base_stat"
            case statName = "stat"
        }

        struct StatName: Decodable, Equatable {
            let name: String
        }
    }

    struct PokemonMove: Decodable, Equatable {
        let move: MoveName

        struct MoveName: Decodable, Equatable {
            let name: String
        }
    }

    enum PokemonType: String, Decodable {
        case normal
        case fire
        case fighting
        case water
        case flying
        case grass
        case poison
        case electric
        case ground
        case psychic
        case rock
        case ice
        case bug
        case dragon
        case ghost
        case dark
        case steel
        case fairy
    }
}
