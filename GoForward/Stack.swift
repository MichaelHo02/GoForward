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

typealias Stack = [Card]

enum HandType: Int {
    case None = 0, Single, Pair, ThreeOfAKind, Straight, PairInStraight, FourOfAKind
    
    /// Classify the type of hand
    /// - Parameter hand: hand (a list of cards)
    init(_ hand: Stack) {
        var type: Self = .None
        
        if hand.count == 1 {
            type = .Single
        }
        
        if hand.isSameRank() {
            switch hand.count {
            case 2:
                type = .Pair
            case 3:
                type = .ThreeOfAKind
            case 4:
                type = .FourOfAKind
            default:
                type = .None
            }
        }
        
        let sortedHand = hand.sorted(by: <)
        if sortedHand.isStraight() {
            type = .Straight
        }
        
        if sortedHand.isPairInStraight() {
            type = .PairInStraight
        }
        
        
        self = type
    }
}

extension Stack where Element == Card {
    /// This function will check if the list of cards are same rank
    /// - Returns: true if it is same rank
    func isSameRank() -> Bool {
        if self.count < 2 { return  false }
        for i in 1 ..< self.count {
            if self[i - 1].rank != self[i].rank {
                return false
            }
        }
        return true
    }
    
    /// This function will check if the list of cards are straight
    /// - Returns: true if it is same rank
    func isStraight() -> Bool {
        self.count > 2 && canBeStraight()
    }
    
    /// This function will check if the list is pair in straight
    /// - Returns: true if it is pair in straight
    func isPairInStraight() -> Bool {
        self.count % 2 == 0 && count >= 6 && canBePairInStraight()
    }
    
    /// This function check if the list of cards can be straight (meaning it does satified the fact that it is straight but not yet valid according to the rule)
    /// - Returns: true if it can be straight
    func canBeStraight() -> Bool {
        for i in 1 ..< self.count {
            let cardL = self[i - 1], cardR = self[i]
            
            if cardL.rank == .Two || cardR.rank == .Two {
                return false
            }
            
            if cardR.rank.rawValue - cardL.rank.rawValue != 1 {
                return false
            }
        }
        return true
    }
    
    /// This function check if the list of cards can be pair in straight (meaning it does satified the fact that it is in pair and straight but not yet valid according to the rule)
    /// - Returns: true if it can be pair in straight
    func canBePairInStraight() -> Bool {
        for i in 1 ..< self.count {
            let cardL = self[i - 1], cardR = self[i]
            
            if cardL.rank == .Two || cardR.rank == .Two {
                return false
            }
            
            if (i % 2 != 0 && cardL.rank != cardR.rank) || (i % 2 == 0 && cardR.rank.rawValue - cardL.rank.rawValue != 1) {
                return false
            }
        }
        return true
    }
    
    /// This function chekc if the list of cards is dragon straight
    /// - Returns: true if it is dragon straight
    func isDragonStraight() -> Bool {
        for i in 1 ..< self.count - 1 {
            let cardL = self[i - 1], cardR = self[i]
            if cardR.rank.rawValue - cardL.rank.rawValue != 1 {
                return false
            }
        }
        return true
    }
}
