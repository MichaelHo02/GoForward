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

struct HowToPlayView: View {
    @StateObject var howToPlayVM = HowToPlayViewModel()
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    Spacer(minLength: 80)
                    ForEach(howToPlayVM.headers, id: \.self) { header in
                        Section {
                            VStack(alignment: .leading, spacing: 20) {
                                ForEach(howToPlayVM.sections[header] ?? [String](), id: \.self) { value in
                                    Text(value).multilineTextAlignment(.leading)
                                }
                            }
                            .padding(.horizontal)
                        } header: {
                            Text(header).font(.title3)
                        }
                        
                        Divider()
                    }
                    
                    Section {
                        HStack {
                            Text("Credits:")
                            howToPlayVM.refLink
                        }
                        
                        Text("Developed by Ho Le Minh Thach")
                        
                        HStack {
                            Text("Profile:")
                            howToPlayVM.linkedInLink
                            howToPlayVM.githubLink
                        }
                    }
                }
            }
            
            VStack {
                Header(title: "How To Play?")
                Spacer()
            }
        }
        .onAppear(perform: howToPlayVM.playBGMusic)
        .onChange(of: scenePhase) { newPhase in
            switch (newPhase) {
            case .active:
                howToPlayVM.playBGMusic()
            case .background, .inactive:
                howToPlayVM.stopBGMusic()
            @unknown default:
                fatalError()
            }
            
        }
    }
}
