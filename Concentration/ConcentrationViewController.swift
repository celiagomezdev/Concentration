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
    
    private var faces : [String:Any] = ["emojis" : "😱😳😭😜😘😅😍😎😂", "backgroundColor": #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), "cardColor": #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), "playAgainButton": #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) ]

    private var halloween : [String:Any] = ["emojis" : "👻🎃🙀🦇🍭🍬🍎😈😱", "backgroundColor": #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), "cardColor": #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), "playAgainButton": #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) ]

    private var nature : [String:Any] = ["emojis" : "🐸🐛🌸🍄🌻🕷🐌🌳🌹", "backgroundColor": #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), "cardColor": #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), "playAgainButton": #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) ]

    private var party : [String:Any] = ["emojis" : "🎊🎈🎉🍻🍾🍸🕺💃🏻🤪", "backgroundColor": #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), "cardColor": #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), "playAgainButton": #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) ]

    lazy var themes = [halloween, nature, party, faces]
    
    private var selectedTheme: [String:Any]!
    
    override func viewDidLoad() {
        selectedTheme = faces
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        game.flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("This button is not properly connected")
        }
    }
    
    private func updateViewFromModel() {
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
    }
    
    lazy private var emojiChoices = selectedTheme["emojis"] as! String
    
    private var emoji = [Card:String]()
    
    private func emoji(for card: Card) -> String {

        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }

        return emoji[card] ?? "?"
    }
    
    private func renewEmojis() {
        emojiChoices.removeAll()
        emoji.removeAll()
        emojiChoices = selectedTheme["emojis"] as! String
    }
    
//    private func selectNewTheme() {
//        let randomIndex = Int(arc4random_uniform(UInt32(themes.count)))
//        selectedTheme = themes[randomIndex]
//
//        if let backgroundColor = selectedTheme["backgroundColor"] as? UIColor {
//            view.backgroundColor = backgroundColor
//        }
//
//        if let playAgainButtonColor = selectedTheme["playAgainButton"] as? UIColor {
//            playAgainButton.setTitleColor(playAgainButtonColor, for: UIControlState.normal)
//        }
//
//        if let labelTextColor = selectedTheme["cardColor"] as? UIColor {
//            flipCountLabel.textColor = labelTextColor
//        }
//
//        emojiChoices = selectedTheme["emojis"] as! String
//    }
    
        
    @IBAction private func playAgain(_ sender: UIButton) {
        renewEmojis()
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        updateViewFromModel()
    }
}

