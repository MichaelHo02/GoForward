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
            let discardedHands = gameVM.discardedHands
            ForEach(Array(discardedHands.enumerated()), id: \.offset) { idx, discardHand in
                VStack {
                    Spacer()
                    HandView(stack: discardHand.hand, minWidth: 60, maxWidth: maxWidth, spacing: -30, dealingNameSpace: dealingNameSpace) {_ in}
                        .padding(.horizontal)
                        .scaleEffect(idx == 1 && discardedHands.count == 2 || discardedHands.count <= 1 ? 1 : 0.8)
                        .offset(y: idx == 1 && discardedHands.count == 2 || discardedHands.count <= 1 ? 0 : offset)
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 2)
    }
}
