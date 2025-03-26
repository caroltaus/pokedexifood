//
//  Pokemon.swift
//  pokedex
//
//  Created by Caroline Taus on 25/03/25.
//
import Foundation

struct Pokemon: Decodable, Equatable {
    let id: Int
    let name: String
    let order: Int
    let baseExperience: Int
    let height: Int
    let weight: Int
    let sprite: Sprite
    
    enum CodingKeys: String, CodingKey {
        case id, name, order, height, weight
        case sprite = "sprites"
        case baseExperience = "base_experience"
    }
    
    struct Sprite: Decodable, Equatable {
        let image: URL?
        
        enum SpriteCodingKeys: String, CodingKey {
            case other
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
            let officialArtworkContainer = try? otherContainer?.nestedContainer(keyedBy: OfficialArtworkCodingKeys.self, forKey: .officialArtwork)
            self.image = try? officialArtworkContainer?.decode(URL.self, forKey: .frontDefault)
        }
    }
}
