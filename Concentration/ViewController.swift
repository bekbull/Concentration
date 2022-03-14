//
//  ViewController.swift
//  Concentration
//
//  Created by Bekbull on 02.03.2022.
//

import UIKit

class ViewController: UIViewController {
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    private var themes = [
        [
            "🥎", "🥏",  "⚽️", "🏓",
            "⚾️", "🥊", "🏀", "🏐",
            "🏉", "🎾", "🏹", "⛸",
        ],
        [
            "🍏", "🍐",  "🍊", "🍌",
            "🍇", "🥥", "🥕", "🫑",
            "🍟", "🍕", "🍔", "🥑",
        ],
        [
            "🦊", "🐼", "🦁", "🐘",
            "🐓", "🦀", "🐷", "🦉"
        ],
        [
            "💻", "🖥", "⌚️", "☎️",
            "🖨", "🖱", "📱", "⌨️"
        ]
    ]
    
    private var emojiChoices = [String]()
    
    private var emoji = Dictionary<Int, String>()
    
    private func themeChoose(){
        emojiChoices = themes[themes.count.arc4random]
        print(emojiChoices)
    }
    
    @IBAction func restartGame(_ sender: UIButton) {
        themeChoose()
        emoji = Dictionary<Int, String>()
        game.restart()
        updateViewFromModel()

    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chosenCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("no card")
        }
    }
    private func updateViewFromModel() {
        scoreLabel.text = "Score: \(game.score)"
        flipCountLabel.text = "Flips: \(game.flipCount)"
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = UIColor.white
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        themeChoose()
    }
    
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return Int(arc4random_uniform(UInt32(abs(self))))
        }
        return 0
    }
}
