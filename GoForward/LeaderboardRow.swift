//
//  LeaderboardRow.swift
//  GoForward
//
//  Created by Ho Le Minh Thach on 25/08/2022.
//

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
