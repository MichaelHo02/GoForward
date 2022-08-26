//
//  CustomProgressViewStyle.swift
//  GoForward
//
//  Created by Ho Le Minh Thach on 26/08/2022.
//

import Foundation
import SwiftUI

struct CustomProgressViewStyle: ProgressViewStyle {
    let color1 = Color("Color1")
    let color2 = Color("Color2")
    let color3 = Color("Color3")
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack(alignment: .leading) {
            Capsule()
                .frame(width: 100, height: 10)
                .foregroundStyle(.thinMaterial)
            
            Capsule()
                .frame(width: CGFloat(configuration.fractionCompleted ?? 0) * 100, height: 10)
                .foregroundStyle(LinearGradient(colors: [color1, color2, color3], startPoint: .leading, endPoint: .trailing))
        }
    }
}
