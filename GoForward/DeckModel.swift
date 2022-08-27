/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Ho Le Minh Thach
 ID: s3877980
 Created  date: 27/08/2022
 Last modified: 27/08/2022
 Learning from Hacking with Swift to implement MVVM, and the usage of CoreData
 Hudson, P. (n.d.). The 100 days of Swiftui. Hacking with Swift. Retrieved July 30, 2022, from https://www.hackingwithswift.com/100/swiftui
*/

import Foundation

/// This is the schema for storing the deck
struct Deck {
    private(set) var stack = Stack()
    var deckCount: Int {
        stack.count
    }
    
    mutating func createDeck() {
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
}
