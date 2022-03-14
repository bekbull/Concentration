//
//  Concentration.swift
//  Concentration
//
//  Created by Bekbull on 03.03.2022.
//

import Foundation

class Concentration {
    private(set) var cards = Array<Card>()
    private(set) var score = 0
    private(set) var flipCount = 0
    
    private var index0fOneAndOnlyFaceUpCard: Int? {
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
    
    func chosenCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chosenCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = index0fOneAndOnlyFaceUpCard {
                if matchIndex != index {
                    // cards match
                    if cards[matchIndex].identifier == cards[index].identifier  {
                        cards[matchIndex].isMatched = true
                        cards[index].isMatched = true
                        score += 2
                    } else if cards[matchIndex].wasSeen || cards[index].wasSeen {
                        score -= 1
                    }
                    cards[index].wasSeen = true
                    cards[matchIndex].wasSeen = true
                    flipCount += 1
                    cards[index].isFaceUp = true
                    
                }
            } else {
                flipCount += 1
                // either no cards or 2 cards are face up
                index0fOneAndOnlyFaceUpCard = index
            }
        }
    }
    func restart(){
        for flipDownIndex in cards.indices {
            cards[flipDownIndex].isFaceUp = false
            cards[flipDownIndex].isMatched = false
            cards[flipDownIndex].wasSeen = false
        }
        flipCount = 0
        score = 0
    }
    init(numberOfPairsOfCards: Int){
        assert(numberOfPairsOfCards > 0, "Concentration.init(at: \(numberOfPairsOfCards)): you must have at least one pair of cards")

        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
}
