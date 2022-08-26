//
//  GameModel.swift
//  GoForward
//
//  Created by Ho Le Minh Thach on 26/08/2022.
//

import Foundation
import SwiftUI

struct GameModel {
    private var discardedHands = [DiscardHand]()
    private(set) var players = [Player]()
    var currentPlayerIdx = 0
    private var firstPlayer = true
    private(set) var gameEnded = false
    private var isHumanWin = false
    var skipRound: [Bool]
    
    var bots: [Player] {
        players.filter { !$0.isHuman }
    }
    
    var human: Player {
        players.filter{ $0.isHuman }.first ?? Player()
    }
    
    mutating func setHumanName(_ name: String) {
        players[players.count - 1].name = name
    }
    
    mutating func updateDeal(_ playerIdx: Int, _ card: Card) {
        players[playerIdx].hand.append(card)
    }
    
    mutating func showHumanHand(_ i: Int) {
        players[players.count - 1].hand[i].hideCard = false
    }
    
    mutating func getNextPlayer() -> Player {
        if firstPlayer {
            firstPlayer = false
        } else {
            self.players[currentPlayerIdx].isActive = false
            self.currentPlayerIdx = (self.currentPlayerIdx + 1) % self.players.count
            while skipRound[currentPlayerIdx] {
                self.currentPlayerIdx = (self.currentPlayerIdx + 1) % self.players.count
            }
        }
        players[self.currentPlayerIdx].isActive = true
        
        if let lastDiscardedHand = discardedHands.last {
            if lastDiscardedHand.handOwner == players[self.currentPlayerIdx] {
                discardedHands.removeAll()
                skipRound = Array(repeating: false, count: players.count)
            }
        }
        
        return players[self.currentPlayerIdx]
    }
    
    init() {
        self.players = [Player]()
        for name in ["Apple", "Banana", "Chip"] {
            self.players.append(Player(name: name))
        }
        self.players.append(Player(isHuman: true))
        skipRound = Array(repeating: false, count: players.count)
    }
    
}
