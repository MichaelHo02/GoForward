//
//  DeckModel.swift
//  GoForward
//
//  Created by Ho Le Minh Thach on 25/08/2022.
//

import Foundation

struct Deck {
    private(set) var stack = Stack()
    
    init() {
        for suit in Suit.allCases {
            for rank in Rank.allCases {
                stack.append(Card(rank: rank, suit: suit))
            }
        }
    }
    
    mutating func drawCard() -> Card {
        stack.removeLast()
    }
    
    mutating func shuffle() {
        stack.shuffle()
    }
    
    func cardsRemaining() -> Int {
        stack.count
    }
}
