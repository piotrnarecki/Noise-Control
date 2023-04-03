//
//  SoundRecorder.swift
//  Noise Control
//
//  Created by Piotr Narecki on 03/04/2023.
//

import Foundation
import AVKit
import AVFoundation

class SoundRecorder{
    
    var frequency: Float=0.0
    var dbValue: Float=0.0
    var micTimer: Timer?
    
    func recordSound() ->Float{
                
    
        setUpAudioCapture()
        captureAudio()
        
        return dbValue
        
        
        
    }
    
    func stopRecording(){
        
    
        micTimer?.invalidate()
        print("timer stopped")
        
    }
    
    
    
    
    
    
    
    
    // https://betterprogramming.pub/detecting-microphone-input-levels-in-your-ios-application-e5b96bf97c5c
    
    private func setUpAudioCapture() {
        
        let recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(.playAndRecord)
            try recordingSession.setActive(true)
            
            recordingSession.requestRecordPermission({ result in
                guard result else { return }
            })
            
            //captureAudio()
            
        } catch {
            print("ERROR: Failed to set up recording session.")
        }
    }
    
    private func captureAudio() {
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let audioFilename = documentPath.appendingPathComponent("recording.m4a")
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        // ...
        
        do {
            let audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.record()
            audioRecorder.isMeteringEnabled = true
            
            
             micTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) {_ in
                audioRecorder.updateMeters()
                let db = audioRecorder.averagePower(forChannel: 0)
                print("\(db) dB")
                
                let pp = audioRecorder.peakPower(forChannel: 0)
               print(" pp \(pp)")
                
                
                
                
            }
        } catch {
            print("ERROR: Failed to start recording process.")
        }
        
        
    }}
