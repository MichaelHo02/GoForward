//
//  OpponentSection.swift
//  GoForward
//
//  Created by Ho Le Minh Thach on 25/08/2022.
//

import SwiftUI

struct OpponentSection: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var gameVM: GameViewModel
    let dealingNameSpace: Namespace.ID
    
    var body: some View {
        if verticalSizeClass == .compact {
            VStack(alignment: .leading, spacing: 5) {
                ForEach(gameVM.bots, id: \.id) { bot in
                    HStack {
                        Avatar(image: Image("user\(bot.id.uuid.0 % 7)"))
                        HandView(stack: bot.hand, minWidth: 25, maxWidth: 25, spacing: -22, dealingNameSpace: dealingNameSpace) {_ in}
                            .frame(width: 80)
                        Text(bot.name)
                        Spacer()
                    }
                    .modifier(OpponentSectionModifier(isActive: bot.isActive))
                }
            }
        } else {
            HStack(spacing: 10) {
                ForEach(gameVM.bots, id: \.id) { bot in
                    VStack(spacing: 0) {
                        Avatar(image: Image("user\(bot.id.uuid.0 % 7)"))
                        Text(bot.name)
                            .fixedSize()
                        HandView(stack: bot.hand, minWidth: 25, maxWidth: 25, spacing: -22, dealingNameSpace: dealingNameSpace) {_ in}
                            .frame(width: 80)
                    }
                    .modifier(OpponentSectionModifier(isActive: bot.isActive))
                }
            }
        }
    }
}
