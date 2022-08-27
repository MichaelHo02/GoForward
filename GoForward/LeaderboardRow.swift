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

struct LeaderboardRow: View {
    let user: User
    
    var body: some View {
        HStack {
            Avatar(image: Image("user\((user.id?.uuid.0 ?? 0) % 7)"))
            Text(user.name ?? "Unavailable")
            Spacer()
            Text("Score: \(user.score)")
            HStack {
                if user.isWin {
                    Image(systemName: "crown.fill")
                        .font(.title)
                        .foregroundColor(.yellow)
                }
            }
            .frame(width: 40)
        }
        .padding(10)
        .background(Color("Color\(user.isWin ? 4 : 6)"))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
