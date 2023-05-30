//
//  SoundPlayer.swift
//  Noise Control
//
//  Created by Piotr Narecki on 30/05/2023.
//

import Foundation
import AudioUnit
import AVFoundation



class SoundPlayer: NSObject {
    

    var audioPlayer: AVAudioPlayer?

    
    
     func playSound(){
        
         
         let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
         let audioFilename = documentPath.appendingPathComponent("recording.m4a")
         
        
         

         print ("AUDIO FILENAME PLAYER \(audioFilename)")


        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFilename)
            audioPlayer?.play()
            
            print("playing started")

            
        } catch {
            print("couldn't load file :(")
        }
        
    }
    
    
     func stopPlaying(){
        
        
        audioPlayer?.stop()
        
         print("playing stopped")

    }
    
    
    
}
