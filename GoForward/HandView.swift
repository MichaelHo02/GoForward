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
