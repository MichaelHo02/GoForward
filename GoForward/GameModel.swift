//
//  GameModel.swift
//  GoForward
//
//  Created by Ho Le Minh Thach on 26/08/2022.
//

import Foundation
import SwiftUI

struct GameModel: Codable {
    private var discardedHands = [DiscardHand]()
    private(set) var players = [Player]()
    var currentPlayerIdx = 0
    private var firstPlayer = true
    private(set) var gameEnded = false
    var isHumanWin = false
    var skipRound: [Bool]
    
    var endRound: Bool {
        discardedHands.isEmpty
    }
    
    var bots: [Player] {
        players.filter { !$0.isHuman }
    }
    
    var human: Player {
        players.filter{ $0.isHuman }.first ?? Player()
    }
    
    var discardedhand: [DiscardHand] {
        if self.discardedHands.count < 3 {
            return self.discardedHands
        }
        return Array(self.discardedHands.suffix(2))
    }
    
    mutating func setHumanName(_ name: String) {
        players[players.count - 1].name = name
    }
    
    mutating func updateDealCard(_ playerIdx: Int, _ card: Card) {
        players[playerIdx].hand.append(card)
    }
    
    mutating func showHumanHand(_ i: Int) {
        players[players.count - 1].hand[i].hideCard = false
    }
    
    mutating func sortHumanHand() {
        players[players.count - 1].hand.sort(by: <)
    }
    
    func getCurrentPlayer() -> Player {
        players[self.currentPlayerIdx]
    }
    
    mutating func getNextPlayer() -> Player {
        if firstPlayer {
            firstPlayer = false
        } else {

        }
        self.players[currentPlayerIdx].isActive = false
        self.currentPlayerIdx = (self.currentPlayerIdx + 1) % self.players.count
        while skipRound[currentPlayerIdx] {
            self.currentPlayerIdx = (self.currentPlayerIdx + 1) % self.players.count
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
    
    func allowToPlay(_ player: Player) -> Bool {
        if let idx = players.firstIndex(where: { $0 == player }) {
            return !skipRound[idx]
        }
        return true
    }
    
    mutating func select(_ stack: Stack, in player: Player) {
        if let playerIdx = self.players.firstIndex(where:  {$0 == player }) {
            stack.forEach { card in
                if let cardIdx = self.players[playerIdx].hand.firstIndex(where: { $0 == card }) {
                    self.players[playerIdx].hand[cardIdx].selected.toggle()
                }
            }
        }
    }
    
    mutating func playSelectedHand(of player: Player) {
        if let idx = players.firstIndex(where: { $0 == player}) {
            var playHand = players[idx].hand.filter { $0.selected == true }
            if playHand.isEmpty {
                skipRound[idx] = true
            }
            playHand.sort(by: <)
            if !isPlayable(playHand, of: player) {
                select(playHand, in: player)
                return
            }
            
            for i in 0 ..< playHand.count {
                playHand[i].hideCard = false
            }
            
            players[idx].score += handScore(playHand)
            discardedHands.append(DiscardHand(hand: playHand, handOwner: player))
            players[idx].hand = players[idx].hand.filter { $0.selected == false }
            
            if isWin(player) {
                gameEnded = true
                isHumanWin = player.isHuman
                calculateScoreAfterWinning()
            }
        }
    }
    
    func isPlayable(_ hand: Stack, of player: Player) -> Bool {
        var isPlayable = false
        if let lastDiscardHand = discardedHands.last {
            let handType = HandType(hand)
            let discardHandType = HandType(lastDiscardHand.hand)
            
            if (
                handScore(hand) > handScore(lastDiscardHand.hand) &&
                handType == discardHandType &&
                hand.count == lastDiscardHand.hand.count
            ) {
                isPlayable = true
            }
            
            if player.id == lastDiscardHand.handOwner.id {
                print("This is where he start again")
                isPlayable = true
            }
            
            if lastDiscardHand.hand.contains(where: { $0.rank == .Two }) {
                if discardHandType == .Single &&
                    (handType == .PairInStraight || handType == .FourOfAKind) {
                    isPlayable = true
                } else if discardHandType == .Pair && (handType == .PairInStraight && hand.count >= 8 || handType == .FourOfAKind){
                    isPlayable = true
                } else if discardHandType == .ThreeOfAKind &&
                            handType == .PairInStraight && hand.count >= 10 {
                    isPlayable = true
                }
            } else if handType == .PairInStraight && hand.count >= 8 && discardHandType == .PairInStraight && lastDiscardHand.hand.count < 8 {
                isPlayable = true
            }
        } else {
            if hand.contains(where: { $0.rank == Rank.Three && $0.suit == Suit.Spade }) {
                isPlayable = true
            }
            
            if endRound {
                isPlayable = true
            }
        }
        
        return isPlayable
    }

    mutating func isWin(_ player: Player) -> Bool {
        var result = false
        if let idx = players.firstIndex(where: { $0 == player }) {
            let hand = players[idx].hand
            
            if hand.isEmpty {
                result = true
                players[idx].score += 500
            }
            
            if hand.count == 13 {
                var tmp = hand.filter({ $0.rank == .Three})
                if HandType(tmp) == .FourOfAKind {
                    result = true
                    players[idx].score += handScore(tmp) * HandType.FourOfAKind.rawValue * 5
                }
                
                tmp = hand.filter({ $0.rank == .Two })
                if HandType(tmp) == .FourOfAKind {
                    result = true
                    players[idx].score += handScore(tmp) * HandType.FourOfAKind.rawValue * 10
                }
                
                if hand.reduce(0, {$1.suit == .Heart || $1.suit == .Diamond ? 1 : 0}) == 12 {
                    result = true
                    players[idx].score += 500
                } else if hand.reduce(0, {$1.suit == .Club || $1.suit == .Spade ? 1 : 0}) == 12 {
                    result = true
                    players[idx].score += 500
                }
                
                if hand.isDragonStraight() {
                    result = true
                    players[idx].score += HandType.Straight.rawValue * 100
                }
            }
        }
        return result
    }

    func handScore(_ hand: Stack) -> Int {
        var score = 0
        if hand.isEmpty {
            return score
        }
        for i in 0 ..< hand.count - 1 {
            score += hand[i].cardValue
        }
        if let lastCard = hand.last {
            score += HandType(hand).rawValue * (lastCard.cardValue + hand.count)
        }
        return score
    }
    
    mutating func calculateScoreAfterWinning() {
        for i in 0 ..< players.count {
            players[i].score -= players[i].hand.reduce(0, { $1.cardValue })
        }
    }

    //MARK: AI Agent
    
    mutating func getComputedHand(of player: Player) -> Stack {
        var resultHand = Stack()
        let sortedHand = player.hand.sorted(by: <)
        let allCombination = subsetsHand(sortedHand)
        let sortedHandsByScore = allCombination.sorted {
            getComputerEvaluation($0) > getComputerEvaluation($1)
        }
        for hand in sortedHandsByScore {
            if isPlayable(hand, of: player) {
                resultHand = hand
                break
            }
        }
        return resultHand
    }
    
    func subsetsHand(_ hand: Stack) -> [Stack] {
        var result = [Stack]()
        var subsetHand = Stack()
        
        func deptFirstSearchHand(_ idx: Int) -> Void {
            if idx >= hand.count {
                if HandType(subsetHand) != .None {
                    result.append(subsetHand)
                }
                return
            }
            
            let currentHandType = subsetHand.isEmpty ? .Single : HandType(subsetHand)
            let validArgument = (
                currentHandType == .Single ||
                currentHandType == .Pair ||
                currentHandType == .ThreeOfAKind ||
                currentHandType == .Straight ||
                currentHandType == .PairInStraight ||
                currentHandType == .None && (
                    subsetHand.canBePairInStraight() || subsetHand.canBeStraight()
                )
            )
            if validArgument {
                subsetHand.append(hand[idx])
                deptFirstSearchHand(idx + 1)
                
                let _ = subsetHand.popLast()
                deptFirstSearchHand(idx + 1)
            } else {
                deptFirstSearchHand(hand.count)
            }
        }
        
        deptFirstSearchHand(0)
        return result
    }
    
    func getComputerEvaluation(_ hand: Stack) -> Int {
        var score = 0
        if hand.isEmpty {
            return score
        }
        for i in 0 ..< hand.count - 1 {
            score += 4 * (13 - hand[i].rank.rawValue) + 5 - hand[i].suit.rawValue
        }
        if let lastCard = hand.last {
            score += HandType(hand).rawValue * (lastCard.cardValue + hand.count)
        }
        return score
    }
    
    init() {
        self.players = [Player]()
        for name in ["Apple", "Banana", "Chip"] {
            self.players.append(Player(name: name))
        }
        self.players.append(Player(isHuman: true))
        skipRound = Array(repeating: false, count: players.count)
    }
    
    enum CodingKeys: String, CodingKey {
        case discardedHands
        case players
        case currentPlayerIdx
        case firstPlayer
        case gameEnded
        case isHumanWin
        case skipRound
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.discardedHands = try container.decode([DiscardHand].self, forKey: .discardedHands)
        self.players = try container.decode([Player].self, forKey: .players)
        self.currentPlayerIdx = try container.decode(Int.self, forKey: .currentPlayerIdx)
        self.firstPlayer = try container.decode(Bool.self, forKey: .firstPlayer)
        self.gameEnded = try container.decode(Bool.self, forKey: .gameEnded)
        self.isHumanWin = try container.decode(Bool.self, forKey: .isHumanWin)
        self.skipRound = try container.decode([Bool].self, forKey: .skipRound)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(discardedHands, forKey: .discardedHands)
        try container.encode(players, forKey: .players)
        try container.encode(currentPlayerIdx, forKey: .currentPlayerIdx)
        try container.encode(firstPlayer, forKey: .firstPlayer)
        try container.encode(gameEnded, forKey: .gameEnded)
        try container.encode(isHumanWin, forKey: .isHumanWin)
        try container.encode(skipRound, forKey: .skipRound)
        
    }
}
