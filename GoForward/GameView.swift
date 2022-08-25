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

    @StateObject var gameVM: GameViewModel
    
    init(isNewGame: Bool) {
        _gameVM = StateObject(wrappedValue: GameViewModel(isNewGame: isNewGame))
    }
    
    var body: some View {
        ZStack {
            VStack {
                GameHeader()
                if verticalSizeClass != .compact {
                    OpponentSection()
                }
                Spacer()
                HStack {
                    if verticalSizeClass == .compact {
                        OpponentSection()
                            .frame(width: 220)
                    }
                    TableSection()
                }
                .padding(.horizontal)
                .padding(.bottom, verticalSizeClass != .compact ? 20 : 0)
                HumanSection()
            }
            
            ModalSection()
        }
        .environmentObject(gameVM)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(isNewGame: true)
    }
}
