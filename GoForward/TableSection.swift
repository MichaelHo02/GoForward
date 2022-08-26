//
//  TableSection.swift
//  GoForward
//
//  Created by Ho Le Minh Thach on 25/08/2022.
//

import SwiftUI

struct TableSection: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var gameVM: GameViewModel
    
    let dealingNameSpace: Namespace.ID

    var maxWidth: CGFloat {
        verticalSizeClass == .compact ? 67 : 100
    }
    var offset: CGFloat {
        verticalSizeClass == .compact ? -30 : -80
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .background(Color("Color6"))
                .foregroundStyle(.bar)
            ZStack {
                ForEach(gameVM.deck.stack) { card in
                    CardView(cardName: "back")
                        .frame(width: 50)
                        .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                }
            }
        }
    }
}
