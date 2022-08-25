//
//  ContentView.swift
//  GoForward
//
//  Created by Ho Le Minh Thach on 25/08/2022.
//

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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
