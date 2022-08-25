//
//  Stack.swift
//  GoForward
//
//  Created by Ho Le Minh Thach on 25/08/2022.
//

import Foundation

typealias Stack = [Card]

enum HandType: Int {
    case None = 0, Single, Pair, ThreeOfAKind, Straight, PairInStraight, FourOfAKind
    
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
    func isSameRank() -> Bool {
        if self.count < 2 { return  false }
        for i in 1 ..< self.count {
            if self[i - 1].rank != self[i].rank {
                return false
            }
        }
        return true
    }
    
    func isStraight() -> Bool {
        self.count > 2 && canBeStraight()
    }
    
    func isPairInStraight() -> Bool {
        self.count % 2 == 0 && count >= 6 && canBePairInStraight()
    }
    
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
