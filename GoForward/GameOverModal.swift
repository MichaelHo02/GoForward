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

struct GameOverModal: View {
    @EnvironmentObject var gameVM: GameViewModel
    @EnvironmentObject var pageVM: PageViewModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.ultraThinMaterial)
                .ignoresSafeArea()
            
            VStack {
                Text("Game Over")
                    .modifier(ModalTitleModifier(minWidth: 280, idealWidth: 280, maxWidth: 320))
                
                Text(gameVM.isHumanWin ? "You Win!" : "You Loose!")
                Text("Your score is: \(gameVM.humanScores)!")
                
                HStack {
                    
                    Button(action: pageVM.visitMenu) {
                        Label("Menu", systemImage: "chevron.backward")
                            .frame(width: 110)
                    }
                    .buttonStyle(.bordered)
                    
                    Button(action: pageVM.visitLeaderboardPage) {
                        Label("Highscore", systemImage: "chart.bar.xaxis")
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
        .onAppear {
            Sound.play(sound: gameVM.isHumanWin ? "you_win" : "you_lose", type: "wav", category: .playback)
        }
    }
}
