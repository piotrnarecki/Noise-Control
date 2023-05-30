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

    
    func recordSound(){
               
        
        //starts recording sound
        
    
        setUpAudioCapture()
        captureAudio()
        
        print("recording started")

    }
    
    func stopRecording(){
        
    

        print("recording stopped")
        
        
        //return recorded file
        
    }
    
    
 //https://betterprogramming.pub/detecting-microphone-input-levels-in-your-ios-application-e5b96bf97c5c
    
    private func setUpAudioCapture() {
        
        let recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(.playAndRecord)
            try recordingSession.setActive(true)
            
            recordingSession.requestRecordPermission({ result in
                guard result else { return }
            })
            
            captureAudio()
            
        } catch {
            print("ERROR: Failed to set up recording session.")
        }
    }
    
    private func captureAudio() {
        
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let audioFilename = documentPath.appendingPathComponent("recording.m4a")
        
        
        print ("AUDIO FILENAME RECORDER \(audioFilename)")
        
        
        
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
    
        } catch {
            print("ERROR: Failed to start recording process.")
        }
        
        
    }}


