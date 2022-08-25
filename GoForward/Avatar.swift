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

struct Avatar_Previews: PreviewProvider {
    static var previews: some View {
        Avatar(image: Image("user0"))
    }
}
