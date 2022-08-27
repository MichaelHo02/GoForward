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

struct LeaderboardView: View {
    @StateObject var leaderboardVM = LeaderboardViewModel()
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        ZStack {
            VStack {
                List {
                    Spacer(minLength: 0)
                    ForEach(leaderboardVM.users) { user in
                        LeaderboardRow(user: user)
                    }
                }
                .listStyle(.sidebar)
            }
            
            VStack {
                Header(title: "Leaderboard")
                Spacer()
            }
        }
        .onAppear {
            leaderboardVM.playBGMusic()
            leaderboardVM.getAllUsers()
        }
        .onChange(of: scenePhase) { newScene in
            switch(newScene) {
            case .background, .inactive:
                Sound.stopBGMusic()
            case .active:
                leaderboardVM.playBGMusic()
            @unknown default:
                fatalError()
            }
        }
    }
}
