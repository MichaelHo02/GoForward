//
//  ContentView.swift
//  GoForward
//
//  Created by Ho Le Minh Thach on 25/08/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var contentVM = ContentViewModel()
    
    var body: some View {
        Group {
            switch contentVM.currentPage {
            case .Menu:
                MenuView()
                    .modifier(ViewTransition(edge: .leading))
            case .Resume:
                GameView()
                    .modifier(ViewTransition(edge: .trailing))
            case .Game:
                GameView()
                    .modifier(ViewTransition(edge: .trailing))
            case .Leaderboard:
                LeaderboardView()
                    .modifier(ViewTransition(edge: .trailing))
            case .HowToPlay:
                HowToPlayView()
                    .modifier(ViewTransition(edge: .trailing))
            }
        }
        .environmentObject(contentVM)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
