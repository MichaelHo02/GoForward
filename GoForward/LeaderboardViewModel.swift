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

final class LeaderboardViewModel: ObservableObject {
    @Published var users: [User] = []
    
    /// This function will fetch and store all users scores
    func getAllUsers() {
        users = DataController.shared.getAllUsers()
    }
    
    /// This function will start the background music
    func playBGMusic() {
        Sound.play(sound: "theme", type: "mp3", category: .ambient, volume: 1, numberOfLoops: -1, isBackgroundMusic: true)
    }
}
