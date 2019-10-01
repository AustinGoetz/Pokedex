//
//  Pokemon.swift
//  Pokedex
//
//  Created by Austin Goetz on 10/1/19.
//  Copyright © 2019 Austin Goetz. All rights reserved.
//

import Foundation

struct TopLevelDictionary: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case abilities
        case name
        case id
        case spriteDictionary = "sprites"
    }
    
    let id: Int
    let name: String
    let spriteDictionary: SpriteDictionary
    let abilities: [AbilityDictionary]
}

struct SpriteDictionary: Decodable {
    private enum CodingKeys: String, CodingKey {
        case image = "front_shiny"
    }
    let image: URL
}

struct AbilityDictionary: Decodable {
    let ability: Ability
    
}

struct Ability: Decodable {
    let name: String
}
