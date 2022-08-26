//
//  BottomBar.swift
//  GoForward
//
//  Created by Ho Le Minh Thach on 25/08/2022.
//

import SwiftUI

struct BottomBar: View {
    @EnvironmentObject var gameVM: GameViewModel
    
    var body: some View {
        let human = gameVM.human
        return HStack {
            Button(action: gameVM.resetCards) {
                Label("Reset", systemImage: "trash")
                    .labelStyle(.iconOnly)
                    .frame(width: 30, height: 20)
            }
            .buttonStyle(.bordered)
            Spacer()
            VStack(spacing: 0) {
                let handType = HandType(gameVM.humanHand.filter({ $0.selected }))
                Text("\(String(describing: handType))")
                    .padding(0)
                ProgressView("Timelimit", value: gameVM.counter, total: 10)
                    .progressViewStyle(CustomProgressViewStyle())
            }
            Spacer()
            Button(action: gameVM.playCards) {
                Label("Play", systemImage: "play")
                    .labelStyle(.iconOnly)
                    .frame(width: 30, height: 20)
            }
            .disabled(!human.isActive)
            .buttonStyle(.borderedProminent)
        }
        .modifier(BottomBarModifier())
        .background(human.isActive ? Color("Color6") : nil)
    }
}
