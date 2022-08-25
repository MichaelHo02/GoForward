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
            .transition(
                .move(edge: edge)
                .combined(with: .opacity)
            )
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
