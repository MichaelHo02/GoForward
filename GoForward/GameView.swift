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

struct GameView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.scenePhase) var scenePhase
    @Namespace var dealingNameSpace

    @StateObject var gameVM: GameViewModel
    
    init(isNewGame: Bool) {
        _gameVM = StateObject(wrappedValue: GameViewModel(isNewGame: isNewGame))
    }
    
    var body: some View {
        ZStack {
            VStack {
                GameHeader()
                if verticalSizeClass != .compact {
                    OpponentSection(dealingNameSpace: dealingNameSpace)
                }
                HStack {
                    if verticalSizeClass == .compact {
                        OpponentSection(dealingNameSpace: dealingNameSpace)
                            .frame(width: 220)
                    }
                    TableSection(dealingNameSpace: dealingNameSpace)
                }
                .padding(.horizontal)
                .padding(.bottom, verticalSizeClass != .compact ? 20 : 0)
                HumanSection(dealingNameSpace: dealingNameSpace)
            }
            if gameVM.deck.stack.isEmpty && !gameVM.hasStartGame {
                Button(action: gameVM.startGame) {
                    Label("Start Game", systemImage: "play")
                }
                .buttonStyle(.borderedProminent)
            }
            ModalSection()
        }
        .environmentObject(gameVM)
        .edgesIgnoringSafeArea(.bottom)
        .onAppear(perform: gameVM.onAppear)
        .onReceive(gameVM.timer) { time in
            gameVM.runTimerAction()
        }
        .onChange(of: scenePhase) { newPhase in
            gameVM.updateBaseOnPhase(newPhase)
        }
    }
}
