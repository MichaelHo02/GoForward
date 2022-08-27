//
//  Avatar.swift
//  GoForward
//
//  Created by Ho Le Minh Thach on 25/08/2022.
//

import SwiftUI

struct Avatar: View {
    let image: Image
    
    var body: some View {
        image
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
            .overlay(Circle().strokeBorder(lineWidth: 2))
            .frame(width: 50)
    }
}
