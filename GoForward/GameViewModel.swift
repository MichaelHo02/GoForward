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
    
    /// Check if username is valid or not
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
    
    /// This function will create a new game
    func createGame() {
        deck.createDeck()
        deck.shuffle()
        let startIdx = Int(arc4random()) % players.count
        var j = 0.0
        Sound.play(sound: "cardShuffle", type: "wav", category: .playback, numberOfLoops: 1)
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
                    gameModel.updateDealCard(playerIdx, card)
                }
            }
        }
    }
    
    /// This function will start the game
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
    
    /// This function will make sure the card is selected or deselect
    /// - Parameter card: the list of cards need to toggle selected or deselected
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
    
    /// This function will save game to user default to resume
    func saveGame() {
        if !hasStartGame { return }
        if let encoded = try? JSONEncoder().encode(gameModel) {
            UserDefaults.standard.set(encoded, forKey: dataKey)
        }
    }
    
    /// This function will submit the username and start the new game
    func submit() {
        withAnimation {
            gameModel.setHumanName(username)
            showRegisterModal = false
        }
        createGame()
    }
    
    /// This function will start the timer
    func startTimer() {
        self.timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    }
    
    /// This function will stop the timer
    func stopTimer() {
        self.timer.upstream.connect().cancel()
    }
    
    /// This function will run whenever the timer change
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
    
    /// This function will activate the player including played cards for bots and set the status of player
    /// - Parameter player: the player need to be active
    func activatePlayer(_ player: Player) {
        if !gameModel.allowToPlay(player) { return }
        
        if !player.isHuman {
            let hand = gameModel.getComputedHand(of: player)
            if !hand.isEmpty {
                gameModel.select(hand, in: player)
                Sound.play(sound: "cardShove1", type: "wav", category: .playback)
            } else {
                Sound.play(sound: "cardSlide1", type: "wav", category: .playback)
            }
            withAnimation {
                gameModel.playSelectedHand(of: player)
            }
        } else {
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
    
    /// This function will handle the action when the game is ended
    func handleWinGame() {
        if gameModel.gameEnded {
            saveResult()
            withAnimation(.easeInOut(duration: 0.5)) {
                showGameOverModal = true
            }
            stopTimer()
        }
        UserDefaults.standard.removeObject(forKey: dataKey)
    }
    
    /// This function will save the result of current game to core data
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
    
    /// This function will act when the view is appear the first time
    func onAppear() {
        if showRegisterModal { stopTimer() }
        Sound.play(sound: "waiting1", type: "mp3", category: .ambient, numberOfLoops: -1, isBackgroundMusic: true)
    }
    
    /// This function will act when user click on trash bin to deselect cards
    func resetCards() {
        Sound.play(sound: "cardShove1", type: "wav", category: .playback)
        withAnimation {
            gameModel.deSelect(humanHand.filter({ $0.selected }), in: human)
        }
    }
    
    /// This function will act when user press play button
    func playCards() {
        Sound.play(sound: "cardSlide1", type: "wav", category: .playback)
        counter = 10
        withAnimation {
            gameModel.playSelectedHand(of: human)
        }
    }
    
    /// This funcion will activate when user click resume the game in pause modal
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
    
    /// This function will chnage the behavior of game view when app is active, inactive or backgroun
    /// - Parameter newPhase: the new phase of the app
    func updateBaseOnPhase(_ newPhase: ScenePhase) {
        if !hasStartGame { return }
        if newPhase == .background || newPhase == .inactive {
            Sound.stopBGMusic()
            stopTimer()
            showPauseModal = true
        }
        
        if newPhase == .background {
            saveGame()
        }
    }
    
    
    /// Init the game base on the status of isNewGame if it is not new game then load the data from user default
    /// - Parameter isNewGame: the status of the game view
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
