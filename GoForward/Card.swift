//
//  Card.swift
//  GoForward
//
//  Created by Ho Le Minh Thach on 25/08/2022.
//

import Foundation

enum Rank: Int, CaseIterable, Comparable, Codable {
    static func < (lhs: Rank, rhs: Rank) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
    
    case Three = 1, Four, Five, Six, Seven, Eight, Nine, Ten, J, Q, K, A, Two
}

enum Suit: Int, CaseIterable, Comparable, Codable {
    static func < (lhs: Suit, rhs: Suit) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
    
    case Spade = 1, Club, Diamond, Heart
}

struct Card: Identifiable, Equatable, Comparable, Codable {
    static func < (lhs: Card, rhs: Card) -> Bool {
        lhs.cardValue < rhs.cardValue
    }
    
    var id = UUID()
    let rank: Rank
    let suit: Suit
    var selected = false
    var hideCard = true
    var fileName: String {
        if hideCard {
            return "back"
        }
        return "\(suit)\(rank)"
    }
    let cardValue: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case rank
        case suit
        case selected
        case hideCard
        case cardValue
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.rank = try container.decode(Rank.self, forKey: .rank)
        self.suit = try container.decode(Suit.self, forKey: .suit)
        self.selected = try container.decode(Bool.self, forKey: .selected)
        self.hideCard = try container.decode(Bool.self, forKey: .hideCard)
        self.cardValue = try container.decode(Int.self, forKey: .cardValue)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(rank, forKey: .rank)
        try container.encode(suit, forKey: .suit)
        try container.encode(selected, forKey: .selected)
        try container.encode(hideCard, forKey: .hideCard)
        try container.encode(cardValue, forKey: .cardValue)
    }
    
    init(rank: Rank, suit: Suit) {
        self.cardValue = 4 * (rank.rawValue - 1) + suit.rawValue
        self.rank = rank
        self.suit = suit
    }
}
