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

struct MenuView: View {
    @EnvironmentObject var pageVM: PageViewModel
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    let resumeLabel = Label("Resume", systemImage: "gamecontroller")
        .modifier(ButtonModifier())
    let playGameLabel = Label("Play Game", systemImage: "gamecontroller")
        .modifier(ButtonModifier())
    let leaderboardLabel = Label("Leaderboard", systemImage: "chart.bar.xaxis")
        .modifier(ButtonModifier())
    let howToPlayLabel = Label("How to play", systemImage: "questionmark.circle")
        .modifier(ButtonModifier())
    
    var body: some View {
        Group {
            if horizontalSizeClass == .compact && verticalSizeClass == .regular {
                VStack {
                    Text("Tien Len")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.red)
                        .padding(.top, 30)
                    Text("Go Forward")
                        .font(.title3)
                        .fontWeight(.light)
                        .multilineTextAlignment(.center)
                    Image("appIcon")
                        .resizable()
                        .frame(width: 200.0, height: 200.0)
                    Spacer()
                    if pageVM.isGameSaved {
                        Button(action: pageVM.visitResumePage) { resumeLabel }
                        Button(action: pageVM.visitGamePage) { playGameLabel }
                            .buttonStyle(.bordered)
                    } else {
                        Button(action: pageVM.visitGamePage) { playGameLabel }
                    }
                    Button(action: pageVM.visitLeaderboardPage) { leaderboardLabel }
                        .buttonStyle(.bordered)
                    Button(action: pageVM.visitHowToPlayPage) { howToPlayLabel }
                        .buttonStyle(.bordered)
                    Spacer()
                    Text("Developed by Ho Le Minh Thach")
                }
                .buttonStyle(.borderedProminent)
            }
            else {
                VStack(alignment: .center) {
                    Spacer()
                    HStack {
                        Spacer()
                        VStack(alignment: .center) {
                            Text("Tien Len")
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                                .foregroundColor(.red)
                            Text("Go Forward")
                                .font(.title3)
                                .fontWeight(.light)
                                .multilineTextAlignment(.center)
                            Image("appIcon")
                                .resizable()
                                .frame(width: 100.0, height: 100.0)
                        }
                        Spacer()
                        VStack(alignment: .center) {
                            if pageVM.isGameSaved {
                                Button(action: pageVM.visitResumePage) { resumeLabel }
                                Button(action: pageVM.visitGamePage) { playGameLabel }
                                    .buttonStyle(.bordered)
                            } else {
                                Button(action: pageVM.visitGamePage) { playGameLabel }
                            }
                            Button(action: pageVM.visitLeaderboardPage) { leaderboardLabel }
                                .buttonStyle(.bordered)
                            Button(action: pageVM.visitHowToPlayPage) { howToPlayLabel }
                                .buttonStyle(.bordered)
                        }
                        Spacer()
                    }
                    .buttonStyle(.borderedProminent)
                    Spacer()
                    Text("Developed by Ho Le Minh Thach")
                }
            }
        }
        .onAppear(perform: pageVM.playBGMusic)
        .onChange(of: scenePhase) { newPhase in
            switch (newPhase) {
            case .background, .inactive:
                pageVM.stopBGMusic()
            case .active:
                pageVM.playBGMusic()
            @unknown default:
                fatalError()
            }
        }
    }
}
