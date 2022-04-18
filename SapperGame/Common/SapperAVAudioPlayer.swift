//
//  SapperAVAudioPlayer.swift
//  SapperGame
//
//  Created by pavel mishanin on 13.04.2022.
//

import UIKit
import AVFoundation

enum Sound: String {
    case cat = "Cat"
    case dog = "Dog"
}

final class SapperAVAudioPlayer {
    
    private var player: AVAudioPlayer?
    
    func playSound(sound: Sound) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: "wav") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }
            player.numberOfLoops = 1
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
