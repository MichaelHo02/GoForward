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
import SwiftUI

enum Page {
    case Menu, Resume, Game, Leaderboard, HowToPlay
}

final class PageViewModel: ObservableObject {
    @Published var currentPage: Page = .Menu
    
    /// This function will check if there is data save in user default or not
    var isGameSaved: Bool {
        UserDefaults.standard.data(forKey: dataKey) != nil
    }
    
    /// This function will redirect to menu page
    func visitMenu() {
        withAnimation {
            currentPage = .Menu
        }
    }
    
    /// This function will redirect to resume page
    func visitResumePage() {
        Sound.playButtonSound()
        withAnimation {
            currentPage = .Resume
        }
    }
    
    /// This funciton will redirect to game page
    func visitGamePage() {
        Sound.playButtonSound()
        withAnimation {
            currentPage = .Game
        }
    }
    
    /// This funciton will redirect to leaderboard page
    func visitLeaderboardPage() {
        Sound.playButtonSound()
        withAnimation {
            currentPage = .Leaderboard
        }
    }
    
    /// This function will redirect to how to play page
    func visitHowToPlayPage() {
        Sound.playButtonSound()
        withAnimation {
            currentPage = .HowToPlay
        }
    }
    
    /// This funciton will play the background music
    func playBGMusic() {
        Sound.play(sound: "waiting1", type: "mp3", category: .ambient, numberOfLoops: -1, isBackgroundMusic: true)
    }
    
    /// This function will stop the background music
    func stopBGMusic() {
        Sound.stopBGMusic()
    }
}
