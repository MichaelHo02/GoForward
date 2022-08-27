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
