//
//  DiscardHand.swift
//  GoForward
//
//  Created by Ho Le Minh Thach on 25/08/2022.
//

import Foundation

struct DiscardHand: Identifiable, Equatable, Codable {
    var id = UUID()
    var hand: Stack
    var handOwner: Player
    
    enum CodingKeys: String, CodingKey {
        case id
        case hand
        case handOwner
    }
    
    init(hand: Stack = Stack(), handOwner: Player = Player()) {
        self.hand = hand
        self.handOwner = handOwner
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.hand = try container.decode(Stack.self, forKey: .hand)
        self.handOwner = try container.decode(Player.self, forKey: .handOwner)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(hand, forKey: .hand)
        try container.encode(handOwner, forKey: .handOwner)
    }
}
