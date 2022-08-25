//
//  GameViewModel.swift
//  GoForward
//
//  Created by Ho Le Minh Thach on 25/08/2022.
//

import Foundation
import SwiftUI

final class GameViewModel: ObservableObject {
    enum Level: String, CaseIterable {
        case Easy, Medium, Hard
    }
    
    @Published var gameModel = GameModel()
    @Published var scores = Array(repeating: 0, count: 4)
    @Published var showRegisterModal = false
    @Published var showGameOverModal = false
    @Published var showPauseModal = false
    @Published var username = ""
    @Published var level = Level.Medium
    
    var isValidUserName: Bool {
        let username =  self.username.trim()
        return !(username.isEmpty || username.count > 8)
    }
    
    let isNewGame: Bool
    
    init(isNewGame: Bool) {
        self.isNewGame = isNewGame
        showRegisterModal = isNewGame
    }
    
    func saveGame() {
        
    }
    
    func getHumanScore() -> Int {
        scores[scores.count - 1]
    }
    
    func getBotsScore() -> [Int] {
        scores.suffix(scores.count - 2)
    }
    
    func getScores() {
        
    }
    
    func submit() {
        withAnimation(.easeInOut(duration: 0.5)) {
            gameModel.setHumanName(username)
            showRegisterModal = false
        }
    }
}
