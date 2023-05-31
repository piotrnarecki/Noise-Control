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
    
    var audioRecorder: AVAudioRecorder?
    
    func recordSound(){
        
        
        setUpAudioCapture()
        startRecording()
        
    }
    
    func stopRecording(){
        
        
        audioRecorder?.stop()
        
        
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
            
            // captureAudio()
            
        } catch {
            print("ERROR: Failed to set up recording session.")
        }
    }
    
    private func startRecording() {
        
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let audioFilename = documentPath.appendingPathComponent("recording.m4a")
        
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
                
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder?.record()
            audioRecorder?.isMeteringEnabled = true
            
            
            
        } catch {
            print("ERROR: Failed to start recording process.")
        }
        
        
    }}


