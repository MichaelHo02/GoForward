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

/// Custom styling for progress view
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
