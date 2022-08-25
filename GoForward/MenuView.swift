//
//  MenuView.swift
//  GoForward
//
//  Created by Ho Le Minh Thach on 25/08/2022.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var pageVM: PageViewModel
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
            if pageVM.isGameSaved {
                Button(action: pageVM.visitResumePage) { resumeLabel }
            }
            Button(action: pageVM.visitGamePage) { playGameLabel }
            Button(action: pageVM.visitLeaderboardPage) { leaderboardLabel }
            Button(action: pageVM.visitHowToPlayPage) { howToPlayLabel }
        }
        .buttonStyle(.borderedProminent)
        .onAppear(perform: pageVM.playBGMusic)
        .onChange(of: scenePhase) { newPhase in
            switch (newPhase) {
            case .background, .inactive:
                pageVM.stopBGMusic()
            case .active:
                pageVM.playBGMusic()
            @unknown default:
                fatalError()
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
            .environmentObject(PageViewModel())
    }
}
