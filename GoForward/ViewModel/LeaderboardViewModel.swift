//
//  LeaderboardViewModel.swift
//  GoForward
//
//  Created by Ho Le Minh Thach on 25/08/2022.
//

import Foundation

final class LeaderboardViewModel: ObservableObject {
    @Published var users: [User] = []
    
    func getAllUsers() {
        users = DataController.shared.getAllUsers()
    }
    
    func playBGMusic() {
        Sound.play(sound: "theme", type: "mp3", category: .ambient, volume: 1, numberOfLoops: -1, isBackgroundMusic: true)
    }
}
