//
//  SoundManeger.swift
//  MatchApp
//
//  Created by Ł.B Morapel on 16/03/2021.
//

import Foundation
import AVFoundation

class SoundManeger {
    
    var audioPlayer: AVAudioPlayer?
    
    enum SoundEffect {
        case flip
        case match
        case nomatch
        case shuffle
    }
    
    
    func playSound(effect: SoundEffect)  {
        
        var soundFilename = ""
        
        switch effect {
        
            case .flip:
                soundFilename = "cardFlip"
            case .match:
                soundFilename = "correct"
            case .nomatch:
                soundFilename = "incorrect"
            case .shuffle:
                soundFilename = "shuffle"
                
        }
        // get the path to the resource
       let bundlePath = Bundle.main.path(forResource: soundFilename, ofType: ".wav")
        // check that iss not nil
        guard bundlePath != nil else {
            return
        }
        
        let url = URL(fileURLWithPath: bundlePath!)
        
        do{
            
        audioPlayer = try AVAudioPlayer(contentsOf: url)
            //Play the sound effect
            audioPlayer?.play()
    }
        catch {
            
            print("Couldnt create an audio player")
            return
        }
    }
}
