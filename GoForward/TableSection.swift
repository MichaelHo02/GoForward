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
                .padding(.vertical, 20)
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
