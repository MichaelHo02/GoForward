//
//  Player.swift
//  GoForward
//
//  Created by Ho Le Minh Thach on 25/08/2022.
//

import Foundation

struct Player: Identifiable, Equatable, Codable {
    static func == (lhs: Player, rhs: Player) -> Bool {
        lhs.id == rhs.id
    }
    
    var id = UUID()
    var hand = Stack()
    var isHuman = false
    var isActive = false
    var name = ""
    var score = 0
    
    enum CodingKeys: String, CodingKey {
        case id
        case hand
        case isHuman
        case isActive
        case name
        case score
    }
    
    init(hand: Stack = Stack(), isHuman: Bool = false, isActive: Bool = false, name: String = "", score: Int = 0) {
        self.hand = hand
        self.isHuman = isHuman
        self.isActive = isActive
        self.name = name
        self.score = score
    }
    
    init(isHuman: Bool) {
        self.isHuman = isHuman
    }
    
    init(name: String) {
        self.name = name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.hand = try container.decode(Stack.self, forKey: .hand)
        self.isHuman = try container.decode(Bool.self, forKey: .isHuman)
        self.isActive = try container.decode(Bool.self, forKey: .isActive)
        self.name = try container.decode(String.self, forKey: .name)
        self.score = try container.decode(Int.self, forKey: .score)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(hand, forKey: .hand)
        try container.encode(isHuman, forKey: .isHuman)
        try container.encode(isActive, forKey: .isActive)
        try container.encode(name, forKey: .name)
        try container.encode(score, forKey: .score)
    }
}
