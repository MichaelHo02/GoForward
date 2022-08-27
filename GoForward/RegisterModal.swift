//
//  RegisterModal.swift
//  GoForward
//
//  Created by Ho Le Minh Thach on 25/08/2022.
//

import SwiftUI

struct RegisterModal: View {
    @EnvironmentObject var pageVM: PageViewModel
    @EnvironmentObject var gameVM: GameViewModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.ultraThinMaterial)
                .ignoresSafeArea()
            
            VStack {
                Text("Info")
                    .modifier(ModalTitleModifier(minWidth: 280, idealWidth: 280, maxWidth: 320))
                
                Text("Please enter a name with maximum 8 characters")
                    .font(.caption)
                
                TextField("Username", text: $gameVM.username)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: 280)
                
                HStack {
                    Button(action: pageVM.visitMenu) {
                        Label("Cancel", systemImage: "chevron.backward")
                            .frame(width: 110)
                    }
                    .buttonStyle(.bordered)
                    
                    Button(action: gameVM.submit) {
                        Label("Submit", systemImage: "checkmark.circle")
                            .frame(width: 110)
                    }
                    .disabled(!gameVM.isValidUserName)
                    .buttonStyle(.borderedProminent)
                }
                .frame(width: 280)
                .padding(.vertical)
            }
            .modifier(ModalModifier())
        }
        .modifier(ViewTransition(edge: .top))
        .zIndex(1)
    }
}

struct RegisterModal_Previews: PreviewProvider {
    static var previews: some View {
        RegisterModal()
    }
}
