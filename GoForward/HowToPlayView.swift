//
//  HowToPlayView.swift
//  GoForward
//
//  Created by Ho Le Minh Thach on 25/08/2022.
//

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
