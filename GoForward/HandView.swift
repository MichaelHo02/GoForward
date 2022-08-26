//
//  HandView.swift
//  GoForward
//
//  Created by Ho Le Minh Thach on 25/08/2022.
//

import SwiftUI

struct HandView: View {
    @EnvironmentObject var gameVM: GameViewModel
    var stack: Stack
    let minWidth: CGFloat
    let maxWidth: CGFloat
    let spacing: CGFloat
    let dealingNameSpace: Namespace.ID
    let select: (Card) -> Void
    
    var columns: [GridItem] {
        Array(
            repeating: GridItem(
                .flexible(minimum: minWidth, maximum: maxWidth),
                spacing: spacing
            ),
            count: stack.count
        )
    }

    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(stack, id: \.id) { card in
                CardView(cardName: card.fileName)
                    .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                    .offset(y: card.selected ? -30 : 0)
                    .onTapGesture {
                        select(card)
                    }
            }
        }
    }
}
