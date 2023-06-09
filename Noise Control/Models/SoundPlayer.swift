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

    var isProcessed: Bool?
    
    
    
    func playSound(isProcessed: Bool){
        
         
         let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        
        var audioFilename = documentPath.appendingPathComponent("")


        
        
        if(isProcessed){
             audioFilename = documentPath.appendingPathComponent("original.m4a")

        }else{
             audioFilename = documentPath.appendingPathComponent("original.m4a")
        }
        
        
        
        
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFilename)
            audioPlayer?.play()
            
            
        } catch {
            print("couldn't load file :(")
        }
        
    }
    
    
     func stopPlaying(){
        
        
        audioPlayer?.stop()
        
         print("playing stopped")

    }
    
    
    
}
