//
//  MenuView.swift
//  GoForward
//
//  Created by Ho Le Minh Thach on 25/08/2022.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var contentVM: ContentViewModel
    @Environment(\.scenePhase) var scenePhase
    
    let resumeLabel = Label("Resume", systemImage: "gamecontroller")
        .modifier(ButtonModifier())
    let playGameLabel = Label("Play Game", systemImage: "gamecontroller")
        .modifier(ButtonModifier())
    let leaderboardLabel = Label("Leaderboard", systemImage: "chart.bar.xaxis")
        .modifier(ButtonModifier())
    let howToPlayLabel = Label("How to play", systemImage: "questionmark.circle")
        .modifier(ButtonModifier())
    
    var body: some View {
        VStack {
            if contentVM.isGameSaved {
                Button(action: contentVM.visitResumePage) { resumeLabel }
            }
            Button(action: contentVM.visitGamePage) { playGameLabel }
            Button(action: contentVM.visitLeaderboardPage) { leaderboardLabel }
            Button(action: contentVM.visitHowToPlayPage) { howToPlayLabel }
        }
        .buttonStyle(.borderedProminent)
        .onAppear(perform: contentVM.playBGMusic)
        .onChange(of: scenePhase) { newPhase in
            switch (newPhase) {
            case .background, .inactive:
                contentVM.stopBGMusic()
            case .active:
                contentVM.playBGMusic()
            @unknown default:
                fatalError()
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
            .environmentObject(ContentViewModel())
    }
}
