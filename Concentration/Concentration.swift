//
//  Concentration.swift
//  Concentration
//
//  Created by Celia Gómez de Villavedón on 05/02/2018.
//  Copyright © 2018 Celia Gómez de Villavedón Pedrosa. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    
    func chooseCard(at index: Int) {
        print("Card Index: \(index)")
        if cards[index].isFaceUp {
            cards[index].isFaceUp = false
        } else {
            cards[index].isFaceUp = true
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        //TODO: Shuffle the cards
    }
}
