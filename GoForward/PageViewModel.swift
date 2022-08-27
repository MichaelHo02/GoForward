//
//  ContentViewModel.swift
//  GoForward
//
//  Created by Ho Le Minh Thach on 25/08/2022.
//

import Foundation
import SwiftUI

enum Page {
    case Menu, Resume, Game, Leaderboard, HowToPlay
}

final class PageViewModel: ObservableObject {
    @Published var currentPage: Page = .Menu
    
    var isGameSaved: Bool {
        UserDefaults.standard.data(forKey: dataKey) != nil
    }
    
    func visitMenu() {
        withAnimation {
            currentPage = .Menu
        }
    }
    
    func visitResumePage() {
        Sound.playButtonSound()
        withAnimation {
            currentPage = .Resume
        }
    }
    
    func visitGamePage() {
        Sound.playButtonSound()
        withAnimation {
            currentPage = .Game
        }
    }
    
    func visitLeaderboardPage() {
        Sound.playButtonSound()
        withAnimation {
            currentPage = .Leaderboard
        }
    }
    
    func visitHowToPlayPage() {
        Sound.playButtonSound()
        withAnimation {
            currentPage = .HowToPlay
        }
    }
    
    func playBGMusic() {
        Sound.play(sound: "waiting1", type: "mp3", category: .ambient, numberOfLoops: -1, isBackgroundMusic: true)
    }
    
    func stopBGMusic() {
        Sound.stopBGMusic()
    }
}
