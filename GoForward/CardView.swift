//
//  CardView.swift
//  GoForward
//
//  Created by Ho Le Minh Thach on 25/08/2022.
//

import SwiftUI

struct CardView: View {
    let cardName: String
    
    var body: some View {
        Image(cardName)
            .resizable()
            .aspectRatio(2/3, contentMode: .fit)
    }
}
