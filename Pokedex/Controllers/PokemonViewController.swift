//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by Austin Goetz on 10/1/19.
//  Copyright © 2019 Austin Goetz. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {

    @IBOutlet weak var spriteImageView: UIImageView!
    
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    func updateViews(pokemon: TopLevelDictionary, image: UIImage) {
        // All changes that happen to the UI happen on the main thread. That's what we're doing here
        DispatchQueue.main.async {
            self.pokemonNameLabel.text = pokemon.name
            self.pokemonIDLabel.text = "\(pokemon.id)"
            // Find a way to iterate throught the collection and pull out all the abilities to fill in the label with
            self.pokemonAbilitiesLabel.text = pokemon.abilities[0].ability.name
            self.spriteImageView.image = image
            
        }
    }

} // End of the class

extension PokemonViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        PokemonController.fetchPokemon(with: searchText) { (pokemon) in
            // Now that I have a pokemon, I can get the image
            guard let pokemon = pokemon else {return}
            PokemonController.getImage(pokemon: pokemon) { (image) in
                self.updateViews(pokemon: pokemon, image: image)
            }
        }
    }
}
