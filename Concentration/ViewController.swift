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
   
    var halloween : [String:Any] = ["emojis" : ["👻", "🎃", "🙀", "🦇", "🍭", "🍬", "🍎", "😈", "😱"], "backgroundColor": #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), "cardColor": #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)]
    
    var nature : [String:Any] = ["emojis" : ["🐸", "🐛", "🌸", "🍄", "🌻", "🕷", "🐌", "🌳", "🌹"], "backgroundColor": #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), "cardColor": #colorLiteral(red: 0.4492310882, green: 0.9801079631, blue: 0.474406898, alpha: 1)]
    
    var party : [String:Any] = ["emojis" : ["🎊", "🎈", "🎉", "🍻", "🍾", "🍸", "🕺", "💃🏻", "🤪"], "backgroundColor": #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), "cardColor": #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)]
    
    lazy var themes = [halloween, nature, party]
    
    var selectedTheme: [String:Any]!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    override func viewDidLoad() {
        selectedTheme = halloween
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
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
                if let selectedThemeColor = selectedTheme["cardColor"] as? UIColor {
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : selectedThemeColor
                }
            }
        }
    }
    
    lazy var emojiChoices = selectedTheme["emojis"] as! [String]
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {

        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }

        return emoji[card.identifier] ?? "?"
    }
    
    func selectNewTheme() {
        let randomIndex = Int(arc4random_uniform(UInt32(themes.count)))
        selectedTheme = themes[randomIndex]
        if let backgroundColor = selectedTheme["backgroundColor"] as? UIColor {
            view.backgroundColor = backgroundColor
        }
        emojiChoices = selectedTheme["emojis"] as! [String]
    }
    
        
    @IBAction func playAgain(_ sender: UIButton) {
        emojiChoices.removeAll()
        emoji.removeAll()
        selectNewTheme()
   
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        flipCount = 0
        updateViewFromModel()
    }
}

