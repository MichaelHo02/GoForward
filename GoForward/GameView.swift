//
//  GameView.swift
//  GoForward
//
//  Created by Ho Le Minh Thach on 25/08/2022.
//

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
                    Label("Start Game", systemImage: "start")
                }
                .buttonStyle(.borderless)
            }
            ModalSection()
        }
        .environmentObject(gameVM)
        .edgesIgnoringSafeArea(.bottom)
        .onAppear(perform: gameVM.onAppear)
        .onReceive(gameVM.timer) { time in
            print("Time: \(gameVM.counter)")
            gameVM.runTimerAction()
        }
    }
}
