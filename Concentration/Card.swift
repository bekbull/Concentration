//
//  Card.swift
//  Concentration
//
//  Created by Bekbull on 03.03.2022.
//

import Foundation

struct Card: Hashable {
    var isFaceUp = false
    var isMatched = false
    var wasSeen = false
    private var identifier: Int
    
    var hashValue: Int { return identifier }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int{
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
