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
    

    var audioPlayer1: AVAudioPlayer?
    var audioPlayer2: AVAudioPlayer?


    var isProcessed: Bool?
    
    var soundProcessor: SoundProcessor?
    
    
    
    func playSound(isProcessed: Bool){
        
         
         let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        
        let  audioFilename1 = documentPath.appendingPathComponent("original.m4a")

        let audioFilename2 = documentPath.appendingPathComponent("processed.m4a")

        
        
        
        if(isProcessed){
            soundProcessor=SoundProcessor()
            soundProcessor?.processSound()
            
            do {
                audioPlayer1 = try AVAudioPlayer(contentsOf: audioFilename1)
                audioPlayer2 = try AVAudioPlayer(contentsOf: audioFilename2)

                audioPlayer1?.play()
                audioPlayer2?.play()

                
                
            } catch {
                print("couldn't load file :(")
            }
            
            print("PROCESSING")
            
            
            
        }else{
            print("NO PROCESSIING")

            do {
                audioPlayer1 = try AVAudioPlayer(contentsOf: audioFilename1)
                audioPlayer1?.play()
                
                
            } catch {
                print("couldn't load file :(")
            }
            
        }
        
        
        
        
        
//        do {
//            audioPlayer1 = try AVAudioPlayer(contentsOf: audioFilename1)
//            audioPlayer1?.play()
//
//
//        } catch {
//            print("couldn't load file :(")
//        }
        
    }
    
    
     func stopPlaying(){
        
        
        audioPlayer1?.stop()
         audioPlayer2?.stop()
         
         
        
         print("playing stopped")

    }
    
    
    
}
