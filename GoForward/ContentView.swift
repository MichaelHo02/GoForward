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

import SwiftUI

struct ContentView: View {
    @StateObject private var pageVM = PageViewModel()
    
    var body: some View {
        Group {
            switch pageVM.currentPage {
            case .Menu:
                MenuView()
                    .transition(.move(edge: .leading).combined(with: .opacity))
            case .Resume:
                GameView(isNewGame: false)
                    .modifier(ViewTransition(edge: .trailing))
            case .Game:
                GameView(isNewGame: true)
                    .modifier(ViewTransition(edge: .trailing))
            case .Leaderboard:
                LeaderboardView()
                    .modifier(ViewTransition(edge: .trailing))
            case .HowToPlay:
                HowToPlayView()
                    .modifier(ViewTransition(edge: .trailing))
            }
        }
        .environmentObject(pageVM)
    }
}
