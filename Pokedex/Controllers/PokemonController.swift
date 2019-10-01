//
//  PokemonController.swift
//  Pokedex
//
//  Created by Austin Goetz on 10/1/19.
//  Copyright © 2019 Austin Goetz. All rights reserved.
//

import Foundation
import UIKit

class PokemonController {
    
    static func fetchPokemon(with searchTerm: String, completion: @escaping
        (TopLevelDictionary?) -> Void) {
        
        // Step 1: Input our baseURL which we will build upon below
        guard let baseURL = URL(string: "https://pokeapi.co/api/v2") else
        {return}
        
        // Add the first additional component
        let pokemonComponent = baseURL.appendingPathComponent("pokemon")
        
        // Add the second additional component
        let finalURL = pokemonComponent.appendingPathComponent(searchTerm)
        print(finalURL)
        
        // Start the dataTask
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("There was an error performing the dataTask!! \(error.localizedDescription)")
            }
            
            // Check for data
            if let data = data {
                // If I can create a constant from the value of the data returned in the dataTask completion - then there is data to work with
                
                do {
                let pokemon = try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                completion(pokemon)
                } catch {
                    print("Error Decoding the data into our Pokemon Object \(error.localizedDescription)")
                    completion(nil); return
                }
            }
        }.resume()
    }
    
    static func getImage(pokemon: TopLevelDictionary, completion: @escaping (UIImage) -> Void) {
        
        // Get the URL
        let finalURL = pokemon.spriteDictionary.image
        // Start the dataTask
        let dataTask = URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            // Check for the error
            if let error = error {
                print("Error retrieving the image! \(error.localizedDescription)")
            }
            guard let data = data else {return}
            
            guard let image = UIImage(data: data) else {return}
            completion(image)
        }
        dataTask.resume()
    }
    
} // End of the class
