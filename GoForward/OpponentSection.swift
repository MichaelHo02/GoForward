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
