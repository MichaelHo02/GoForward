//
//  HumanSection.swift
//  GoForward
//
//  Created by Ho Le Minh Thach on 25/08/2022.
//

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
    }
}
