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

/// This is the schema for discarded hand
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
