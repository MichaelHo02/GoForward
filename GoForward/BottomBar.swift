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
