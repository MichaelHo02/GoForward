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
    private var isFirstPlayer = true
    
    @Published var username = ""
    
    var isValidUserName: Bool {
        let username =  self.username.trim()
        return !(username.isEmpty || username.count > 8)
    }
    
    var human: Player {
        gameModel.human
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
    
    var discardedHands: [DiscardHand] {
        gameModel.discardedhand
    }
    
    var isHumanWin: Bool {
        gameModel.isHumanWin
    }
    
    func createGame() {
        deck.createDeck()
        deck.shuffle()
        let startIdx = Int(arc4random()) % players.count
        var j = 0.0
        while deck.deckCount > 0 {
            for i in startIdx ..< startIdx + players.count {
                let playerIdx = i % players.count
                let card = deck.drawCard()
                
                if (card.rank == .Three && card.suit == .Spade) {
                    print(card.rank, card.suit)
                    print("This is the start player", playerIdx)
                    gameModel.currentPlayerIdx = playerIdx
                }
                let delay = Double(j / 10.0)
                j += 1
                withAnimation(.easeInOut(duration: 0.5).delay(delay)) {
                    gameModel.updateDealCard(playerIdx, card)
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
        withAnimation {
            gameModel.sortHumanHand()
        }
        hasStartGame = true
        gameModel.checkPreWinning()
        handleWinGame()
        startTimer()
    }
    
    func select(_ card: Card) {
        if !hasStartGame { return }
        withAnimation(.linear(duration: 0.1)) {
            Sound.play(sound: "cardShove1", type: "wav", category: .playback)
            if card.selected {
                gameModel.deSelect([card], in: human)
            } else {
                gameModel.select([card], in: human)
            }
        }
    }
    
    func saveGame() {
        if !hasStartGame { return }
        if let encoded = try? JSONEncoder().encode(gameModel) {
            UserDefaults.standard.set(encoded, forKey: dataKey)
        }
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
            if !isFirstPlayer {
                let player = gameModel.getCurrentPlayer()
                activatePlayer(player)
                handleWinGame()
            } else {
                isFirstPlayer = false
            }
            
            let playerCur = gameModel.getNextPlayer()
            print("This is current player", playerCur.name)
            if playerCur.isHuman {
                counter = 0
                Sound.play(sound: "go", type: "wav", category: .playback)
            } else {
                counter = 8
            }
            return
        } else if counter == 5 {
            Sound.play(sound: "hurry_up", type: "wav", category: .playback)
        }
        counter += 0.5
    }
    
    func activatePlayer(_ player: Player) {
        if !gameModel.allowToPlay(player) { return }
        
        if !player.isHuman {
            let hand = gameModel.getComputedHand(of: player)
            if !hand.isEmpty {
                print(hand.compactMap({ "\($0.suit) \($0.rank)" }))
                gameModel.select(hand, in: player)
                Sound.play(sound: "cardShove1", type: "wav", category: .playback)
            } else {
                Sound.play(sound: "cardSlide1", type: "wav", category: .playback)
            }
            withAnimation {
                gameModel.playSelectedHand(of: player)
            }
        } else {
            print("This is shit")
            let card = player.hand.filter({ $0.rank == .Three && $0.suit == .Spade })
            if !card.isEmpty {
                withAnimation {
                    gameModel.deSelect(humanHand, in: player)
                    gameModel.select(card, in: player)
                    gameModel.playSelectedHand(of: player)
                }
            }
        }
    }
    
    func handleWinGame() {
        if gameModel.gameEnded {
            saveResult()
            withAnimation(.easeInOut(duration: 0.5)) {
                showGameOverModal = true
            }
            print("Game Ended")
            stopTimer()
        }
        UserDefaults.standard.removeObject(forKey: dataKey)
    }
    
    func saveResult() {
        let context = DataController.shared.viewContext
        let user = User(context: context)
        let human = self.human
        user.id = UUID()
        user.name = human.name
        user.score = Int16(human.score)
        user.isWin = isHumanWin
        DataController.shared.save()
    }
    
    func onAppear() {
        if showRegisterModal { stopTimer() }
        Sound.play(sound: "waiting1", type: "mp3", category: .ambient, numberOfLoops: -1, isBackgroundMusic: true)
    }
    
    func resetCards() {
        Sound.play(sound: "cardShove1", type: "wav", category: .playback)
        gameModel.deSelect(humanHand.filter({ $0.selected }), in: human)
    }
    
    func playCards() {
        Sound.play(sound: "cardSlide1", type: "wav", category: .playback)
        counter = 10
        withAnimation {
            gameModel.playSelectedHand(of: human)
        }
    }
    
    func resumeGame() {
        withAnimation(.easeInOut(duration: 0.5)) {
            withAnimation {
                showPauseModal = false
            }
        }
        Sound.stopBGMusic()
        Sound.play(sound: "waiting1", type: "mp3", category: .ambient, numberOfLoops: -1, isBackgroundMusic: true)
        startTimer()
    }
    
    func updateBaseOnPhase(_ newPhase: ScenePhase) {
        if !hasStartGame { return }
        if newPhase == .background || newPhase == .inactive {
            Sound.stopBGMusic()
            stopTimer()
            showPauseModal = true
        }
        
        if newPhase == .background {
            print("Save game")
            saveGame()
        }
    }
    
    
    init(isNewGame: Bool) {
        showRegisterModal = isNewGame
        self.isNewGame = isNewGame
        if !isNewGame {
            if let data = UserDefaults.standard.data(forKey: dataKey) {
                if let decoded = try? JSONDecoder().decode(GameModel.self, from: data) {
                    gameModel = decoded
                    isFirstPlayer = false
                    startGame()
                    return
                }
            }
        }
        gameModel = GameModel()
    }
}
