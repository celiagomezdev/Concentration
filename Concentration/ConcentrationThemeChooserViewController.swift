//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by Celia Gómez de Villavedón on 16/03/2018.
//  Copyright © 2018 Celia Gómez de Villavedón Pedrosa. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController {

    //Themes
    private var faces : [String:Any] = ["emojis" : "😱😳😭😜😘😅😍😎😂", "backgroundColor": #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), "cardColor": #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), "playAgainButton": #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) ]
    
    private var halloween : [String:Any] = ["emojis" : "👻🎃🙀🦇🍭🍬🍎😈😱", "backgroundColor": #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), "cardColor": #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), "playAgainButton": #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) ]
    
    private var nature : [String:Any] = ["emojis" : "🐸🐛🌸🍄🌻🕷🐌🌳🌹", "backgroundColor": #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), "cardColor": #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), "playAgainButton": #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) ]
    
    private var party : [String:Any] = ["emojis" : "🎊🎈🎉🍻🍾🍸🕺💃🏻🤪", "backgroundColor": #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), "cardColor": #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), "playAgainButton": #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) ]
    


//   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//      if segue
//    }
}
