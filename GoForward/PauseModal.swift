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
