//
//  Sound.swift
//  GoForward
//
//  Created by Ho Le Minh Thach on 25/08/2022.
//

import Foundation
import AVFoundation

class Sound {
    static var soundEffects = [AVAudioPlayer]()
    static var backgroundMusic: AVAudioPlayer? = nil
    
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
    static func stopBGMusic() {
        backgroundMusic?.stop()
    }
    
    static func stopSoundEffect() {
        for sound in soundEffects {
            sound.stop()
        }
        soundEffects.removeAll()
    }
    
    static func playButtonSound(_ sound: String = "Modern8") {
        Sound.play(sound: sound, type: "mp3", category: .ambient, volume: 12)
    }
}
