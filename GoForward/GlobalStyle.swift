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

import Foundation
import SwiftUI

/// Styling for view transition
struct ViewTransition: ViewModifier {
    let edge: Edge
    
    func body(content: Content) -> some View {
        content
            .transition(.move(edge: edge))
    }
}

/// Styling for button in menu page
struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .frame(minWidth: 160)
            .padding(10)
    }
}

/// Styling for the bottom bar in game view
struct BottomBarModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .padding(.bottom, 10)
            .background(.ultraThinMaterial)
    }
}

/// Styling for title in modal
struct ModalTitleModifier: ViewModifier {
    let font = Font.title.bold()
    let minWidth: CGFloat
    let idealWidth: CGFloat
    let maxWidth: CGFloat
    
    func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(.primary)
            .padding(.vertical)
            .frame(minWidth: minWidth, idealWidth: idealWidth, maxWidth: maxWidth)
    }
}

/// Styling for modal
struct ModalModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 2)
    }
}

/// Styling for opponent section view
struct OpponentSectionModifier: ViewModifier {
    let isActive: Bool
    
    func body(content: Content) -> some View {
        content
            .padding(4)
            .background(isActive ? Color("Color6").opacity(0.6) : nil)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: isActive ? 2 : 0)
    }
}
