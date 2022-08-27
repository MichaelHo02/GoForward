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

struct HumanSection: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var gameVM: GameViewModel
    let dealingNameSpace: Namespace.ID
    var spacing: CGFloat {
        verticalSizeClass == .compact ? -50 : -78
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            HandView(stack: gameVM.humanHand, minWidth: 96, maxWidth: 120, spacing: spacing, dealingNameSpace: dealingNameSpace, select: gameVM.select)
                .padding(.horizontal)
                .frame(height: 120)
                .offset(y: 20)
            BottomBar()
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
