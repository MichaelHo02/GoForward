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
import AVFoundation

class Sound {
    /// Save list of effect sounds
    static var soundEffects = [AVAudioPlayer]()
    /// Save a single background music
    static var backgroundMusic: AVAudioPlayer? = nil
    
    /// This function ensure to play music in the bundle
    /// - Parameters:
    ///   - sound: the file name in the bundle
    ///   - type: type of the file
    ///   - category: the role of sound in this app
    ///   - volume: the volumn of the sound
    ///   - numberOfLoops: number of repeated time
    ///   - isBackgroundMusic: is the sound background music?
    static func play(sound: String, type: String, category: AVAudioSession.Category, volume: Float = 1,  numberOfLoops: Int = 0, isBackgroundMusic: Bool = false) {
        if let path = Bundle.main.path(forResource: sound, ofType: type) {
            do {
                let audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer.numberOfLoops = numberOfLoops
               
                if isBackgroundMusic {
                    stopBGMusic()
                    backgroundMusic = audioPlayer
                    backgroundMusic?.setVolume(0.5, fadeDuration: 0.5)
                } else {
                    audioPlayer.volume = volume
                    soundEffects.append(audioPlayer)
                }
                
                audioPlayer.prepareToPlay()
                audioPlayer.play()
                
                let audioSession = AVAudioSession.sharedInstance()
                try audioSession.setCategory(.ambient, mode: .default, options: .mixWithOthers)
                try audioSession.setActive(true)
            } catch {
                print("Error playing sound")
            }
        }
    }
    
    /// Stop the background music
    static func stopBGMusic() {
        backgroundMusic?.stop()
    }
    
    /// Stop all the sound effect and empty the list
    static func stopSoundEffect() {
        for sound in soundEffects {
            sound.stop()
        }
        soundEffects.removeAll()
    }
    
    /// Play the button sound
    /// - Parameter sound: the sound of button
    static func playButtonSound(_ sound: String = "Modern8") {
        Sound.play(sound: sound, type: "mp3", category: .ambient, volume: 12)
    }
}
