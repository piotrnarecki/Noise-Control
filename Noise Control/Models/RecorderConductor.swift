//
//  RecorderConductor.swift
//  Noise Control
//
//  Created by Piotr Narecki on 31/05/2023.
//

import Foundation

class RecorderConductor: NSObject {
    
    var isRunning: Bool = false
    
    var timeInterval: Int = 1000 //co ile rejestrowac [ms]
    
    
    //sound recording
    var soundRecorder: SoundRecorder = SoundRecorder()

    
    //sound playing
    var soundPlayer: SoundPlayer = SoundPlayer()

    
    
    
    
    
    func startConductingRecording(){
        
        
        if(!isRunning){
            
            
            isRunning=true
            soundRecorder.recordSound()
            
            
        }
        
    }
    
    func stopConductingRecording(){
        
        if(isRunning){
            
            isRunning=false
            soundRecorder.stopRecording()

            
        }
        
        
    }
    
    
    func atomicStep(){
        
    //record
        soundRecorder.recordSound()
        //wait
        soundRecorder.stopRecording()
    // 2 play
        soundPlayer.playSound(isProcessed: false)
        //wait
        soundPlayer.stopPlaying()
        
    }
    
    
    
}
