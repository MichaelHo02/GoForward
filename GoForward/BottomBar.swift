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
        HStack {
            Button(action: {}) {
                Label("Reset", systemImage: "trash")
                    .labelStyle(.iconOnly)
                    .frame(width: 30, height: 20)
            }
            .buttonStyle(.bordered)
            Spacer()
            VStack(spacing: 0) {
                ProgressView("Timelimit", value: 10, total: 10)
                    .progressViewStyle(CustomProgressViewStyle())
            }
            Spacer()
            Button(action: {}) {
                Label("Play", systemImage: "play")
                    .labelStyle(.iconOnly)
                    .frame(width: 30, height: 20)
            }
            .disabled(true)
            .buttonStyle(.borderedProminent)
        }
        .modifier(BottomBarModifier())
        .background()
    }
}
