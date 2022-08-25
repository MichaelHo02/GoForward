//
//  GoBack.swift
//  GoForward
//
//  Created by Ho Le Minh Thach on 25/08/2022.
//

import SwiftUI

struct GoBack: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Label("Menu", systemImage: "chevron.backward")
        }
    }
}

struct GoBack_Previews: PreviewProvider {
    static var previews: some View {
        GoBack(action: {})
    }
}
