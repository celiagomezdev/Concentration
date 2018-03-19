//
//  ViewController.swift
//  Concentration
//
//  Created by Celia Gómez de Villavedón on 04/02/2018.
//  Copyright © 2018 Celia Gómez de Villavedón Pedrosa. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private weak var playAgainButton: UIButton!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        game.flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("This button is not properly connected")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewFromModel()
    }
    
    private func updateViewFromModel() {

        if cardButtons != nil {
            flipCountLabel.text = "Flips = \(game.flipCount)"
            for index in cardButtons.indices {
                let button = cardButtons[index]
                let card = game.cards[index]
                if card.isFaceUp {
                    button.setTitle(emoji(for: card), for: UIControlState.normal)
                    button.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
                } else {
                    button.setTitle("", for: UIControlState.normal)
                    if let selectedThemeColor = selectedTheme["cardColor"] as? UIColor {
                        button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : selectedThemeColor
                    }
                }
            }
        } else {
            print("cardButtons is nil: \(cardButtons)")
        }
    }
    
    private func setEmojis() {
        emoji.removeAll()
        emojiChoices = (selectedTheme["emojis"] as? String) ?? ""
    }
    
    var selectedTheme: [String:Any]! {
        didSet {
            setEmojis()
        }
    }
    
    private var emojiChoices: String = ""
    
    private var emoji = [Card:String]()
    
    private func emoji(for card: Card) -> String {

        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }

        return emoji[card] ?? "?"
    }
    

    @IBAction private func playAgain(_ sender: UIButton) {
        setEmojis()
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        updateViewFromModel()
    }
}

