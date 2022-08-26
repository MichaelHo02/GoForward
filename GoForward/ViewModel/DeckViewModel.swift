//
//  DeckViewModel.swift
//  GoForward
//
//  Created by Ho Le Minh Thach on 26/08/2022.
//

import Foundation
import SwiftUI

final class DeckViewModel: ObservableObject {
    @Published private(set) var stack = Stack()
    
    func createDeck() {
        for suit in Suit.allCases {
            for rank in Rank.allCases {
                withAnimation(.easeIn(duration: 0.1).delay(Double(stack.count / 12))) {
                    stack.append(Card(rank: rank, suit: suit))
                }
            }
        }
    }
    
    func drawCard() -> Card {
        stack.removeLast()
    }
    
    func shuffle() {
        stack.shuffle()
    }
    
    func cardsRemaining() -> Int {
        stack.count
    }
}
