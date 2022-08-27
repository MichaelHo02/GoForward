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
