//
//  GameViewModel.swift
//  GoForward
//
//  Created by Ho Le Minh Thach on 26/08/2022.
//

import Foundation
import SwiftUI

final class GameViewModel: ObservableObject {
    @Published var showRegisterModal = false
    @Published var showGameOverModal = false
    @Published var showPauseModal = false
    
    @Published var gameModel: GameModel
    @Published var timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    @Published var counter: Double = 10
    @Published var hasStartGame = false
    private var isNewGame: Bool
    
    enum Level: String, CaseIterable {
        case Easy, Medium, Hard
    }
    
    @Published var username = ""
    @Published var level = Level.Medium
    
    var isValidUserName: Bool {
        return true
    }
    
    var humanHand: Stack {
        gameModel.human.hand
    }
    
    var humanScores: Int {
        gameModel.human.score
    }
    
    var bots: [Player] {
        gameModel.bots
    }
    
    var deck = Deck()
    
    var players: [Player] {
        gameModel.players
    }
    
    func createGame() {
        deck.shuffle()
        let startIdx = Int(arc4random()) % players.count
        var j = 0.0
        while deck.deckCount > 0 {
            for i in startIdx ..< startIdx + players.count {
                let playerIdx = i % players.count
                let card = deck.drawCard()
                
                if (card.rank == .Three && card.suit == .Spade) {
                    gameModel.currentPlayerIdx = playerIdx
                }
                let delay = Double(j / 10.0)
                j += 1
                withAnimation(.easeInOut(duration: 0.5).delay(delay)) {
                    gameModel.updateDeal(playerIdx, card)
                }
            }
        }
    }
    
    func startGame() {
        for i in 0 ..< humanHand.count {
            withAnimation {
                gameModel.showHumanHand(i)
            }
        }
        hasStartGame = true
        startTimer()
    }
    
    func select(_ card: Card) {
        
    }
    
    func saveGame() {
        
    }
    
    func submit() {
        withAnimation {
            gameModel.setHumanName(username)
            showRegisterModal = false
        }
        createGame()
    }
    
    func startTimer() {
        self.timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    }
    
    func stopTimer() {
        self.timer.upstream.connect().cancel()
    }
    
    func runTimerAction() {
        if counter >= 10 {
            if !isNewGame {
                if gameModel.human.isActive {
                    counter = 0
                } else {
                    counter = 8
                }
                self.isNewGame.toggle()
                return
            }
            
            let player = gameModel.getNextPlayer()
            print(player.name)
            activatePlayer(player)
            if player.isHuman {
                print("Is activated: ", player.isActive)
                counter = 0
                Sound.play(sound: "go", type: "wav", category: .playback)
            } else {
                counter = 8
            }
        } else if counter == 5 {
            Sound.play(sound: "hurry_up", type: "wav", category: .playback)
        }
        counter += 0.5
    }
    
    func activatePlayer(_ player: Player) {
        
    }
    
    func onAppear() {
        if showRegisterModal { stopTimer() }
        Sound.play(sound: "waiting1", type: "mp3", category: .ambient, numberOfLoops: -1, isBackgroundMusic: true)
    }
    
    
    
    
    
    init(isNewGame: Bool) {
        gameModel = GameModel()
        showRegisterModal = isNewGame
        self.isNewGame = isNewGame
    }
}
