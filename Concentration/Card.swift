//
//  Card.swift
//  Concentration
//
//  Created by Celia Gómez de Villavedón on 05/02/2018.
//  Copyright © 2018 Celia Gómez de Villavedón Pedrosa. All rights reserved.
//

import Foundation

struct Card {
    
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init(identifier: Int) {
        self.identifier = Card.getUniqueIdentifier()
    }
}