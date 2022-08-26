//
//  ModalSection.swift
//  GoForward
//
//  Created by Ho Le Minh Thach on 25/08/2022.
//

import SwiftUI

struct ModalSection: View {
    @EnvironmentObject var gameVM: GameViewModel
    
    var body: some View {
        if gameVM.showRegisterModal {
            RegisterModal()
                .modifier(ViewTransition(edge: .top))
        }
        
        if gameVM.showGameOverModal {
            GameOverModal()
                .modifier(ViewTransition(edge: .top))
        }
        
        if gameVM.showPauseModal {
            PauseModal()
                .modifier(ViewTransition(edge: .top))
        }
    }
}
