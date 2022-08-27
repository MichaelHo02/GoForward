//
//  PauseModal.swift
//  GoForward
//
//  Created by Ho Le Minh Thach on 25/08/2022.
//

import SwiftUI

struct PauseModal: View {
    @Environment(\.scenePhase) var scenePhase
    @EnvironmentObject var gameVM: GameViewModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.ultraThinMaterial)
                .ignoresSafeArea()
            VStack {
                Text("Pause Game")
                    .modifier(ModalTitleModifier(minWidth: 280, idealWidth: 280, maxWidth: 320))

                HStack {
                    Button(action: gameVM.resumeGame) {
                        Label("Resume", systemImage: "play")
                            .frame(width: 110)
                    }
                    .buttonStyle(.borderedProminent)
                    
                }
                .frame(width: 280)
                .padding(.vertical)
                
            }
            .modifier(ModalModifier())
        }
        .transition(.move(edge: .top))
        .zIndex(1)
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                Sound.play(sound: "theme", type: "mp3", category: .ambient, isBackgroundMusic: true)
            }
        }
    }
}
