//
//  ViewController.swift
//  Concentration
//
//  Created by Celia Gómez de Villavedón on 04/02/2018.
//  Copyright © 2018 Celia Gómez de Villavedón Pedrosa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    @IBOutlet var cardButtons: [UIButton]!
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips = \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBAction func touchCard(_ sender: UIButton) {
        game.flipCount += 1
        flipCount = game.flipCount
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("This button is not properly connected")
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    var emojiChoices = ["👻", "🎃", "🙀", "🦇", "🍭", "🍬", "🍎", "😈", "😱"]
    var emojiChoicesReserve = [String]()
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {

        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            let selectedAndRemovedEmoji = emojiChoices.remove(at: randomIndex)
            emoji[card.identifier] = selectedAndRemovedEmoji
            emojiChoicesReserve.append(selectedAndRemovedEmoji)
        }

        return emoji[card.identifier] ?? "?"
    }
    
        
    @IBAction func playAgain(_ sender: UIButton) {
        emojiChoices += emojiChoicesReserve
        emoji.removeAll()
        emojiChoicesReserve.removeAll()
   
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        flipCount = 0
        updateViewFromModel()
    }
}

