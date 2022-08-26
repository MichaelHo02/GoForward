//
//  GameHeader.swift
//  GoForward
//
//  Created by Ho Le Minh Thach on 25/08/2022.
//

import SwiftUI

struct GameHeader: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var gameVM: GameViewModel
    @EnvironmentObject var pageVM: PageViewModel

    var body: some View {
        HStack {
            GoBack {
                gameVM.saveGame()
                pageVM.visitMenu()
            }
            Spacer()
            
            Text("My Score: \(gameVM.humanScores)")
                .font(.callout)
                .padding()
                .fixedSize()
            
            Menu {
                ForEach(gameVM.bots, id: \.id) { bot in
                    Label("\(bot.name): \(bot.score)", systemImage: "person")
                }
            } label: {
                Label("Scores", systemImage: "chart.bar.xaxis")
                    .labelStyle(.iconOnly)
            }
            .onTapGesture {
                Sound.playButtonSound("Minimalist4")
            }
        }
        .padding(.horizontal)
    }
}

struct GameHeader_Previews: PreviewProvider {
    static var previews: some View {
        GameHeader()
    }
}
