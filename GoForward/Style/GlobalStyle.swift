//
//  GlobalStyle.swift
//  GoForward
//
//  Created by Ho Le Minh Thach on 25/08/2022.
//

import Foundation
import SwiftUI

struct ViewTransition: ViewModifier {
    let edge: Edge
    
    func body(content: Content) -> some View {
        content
            .transition(.move(edge: edge))
    }
}

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .frame(minWidth: 160)
            .padding(10)
    }
}

struct BottomBarModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.top)
            .padding(.horizontal)
            .padding(.bottom, 10)
            .background(.ultraThinMaterial)
    }
}

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

struct ModalModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 2)
    }
}
