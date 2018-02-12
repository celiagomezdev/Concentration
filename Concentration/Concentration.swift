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
    var flipCount = 0
    
    var indexOfOneAndOnlyFaceUpCard: Int? {
        
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            
            return foundIndex
        }
        
        set {
            
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
        
        
    }
    
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        cards.removeAll()
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        //TODO: Shuffle the cards
        var shuffledCards = [Card]()
        
        if cards.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            let shuffledCard = cards.remove(at: randomIndex)
            shuffledCards.append(shuffledCard)
        }
        
        cards += shuffledCards
    }
    
}
