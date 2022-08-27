//
//  LeaderboardView.swift
//  GoForward
//
//  Created by Ho Le Minh Thach on 25/08/2022.
//

import SwiftUI

struct LeaderboardView: View {
    @EnvironmentObject var pageVM: PageViewModel
    @StateObject var leaderboardVM = LeaderboardViewModel()
    
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
    }
}
