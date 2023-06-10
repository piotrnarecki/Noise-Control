//
//  RecorderViewController.swift
//  Noise Control
//
//  Created by Piotr Narecki on 03/04/2023.
//

import UIKit

class RecorderViewController: UIViewController {

    
    @IBOutlet weak var recorderLabel: UILabel!
    
    
    @IBOutlet weak var valueLabel: UILabel!
    
    
    @IBOutlet weak var recordButton: UIButton!
    
    
    @IBOutlet weak var goBackButton: UIButton!
    
    
    @IBOutlet weak var playButton: UIButton!
    
    
    @IBOutlet weak var processSwitch: UISwitch!
    

    
    var isRecording: Bool = false
    
    var soundRecorder: SoundRecorder = SoundRecorder()
    
   // var dbValue: Float = 0.0
    
    
    var isPlaying: Bool = false
    
    var soundPlayer: SoundPlayer = SoundPlayer()
    
    var recordedFileExists: Bool = false
    
    
    ///sound conductor
    var recorderConductor: RecorderConductor = RecorderConductor()
    
    
    ///processing
    
    var isProcessed: Bool = false

    
    
    
    
    override func viewDidLoad() {
        
    
        super.viewDidLoad()
        
        
        isRecording = false
        isPlaying = false
        
        
        isProcessed = processSwitch.isOn
        
    }
    

    @IBAction func recordButtonPressed(_ sender: UIButton) {
        
        
        if(!isRecording){
            
        isRecording=true
           recordSound()
            recordButton.tintColor=UIColor.red
            recordButton.setTitle("stop", for: .normal)
            
            
        }else{
            isRecording=false
            recordButton.tintColor=UIColor.blue
            recordButton.setTitle("record", for: .normal)
            stopRecording()
        }
        
        
        
        
    }
    
    
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        
        if(!isPlaying){
            
        isPlaying=true
            
            playSound(isProcessed:isProcessed)
            
            
            playButton.tintColor=UIColor.red
            playButton.setTitle("stop", for: .normal)
            
            
        }else{
            isPlaying=false
            
            
            playButton.tintColor=UIColor.blue
            playButton.setTitle("play", for: .normal)
            
            
            stopPlaying()
        }
        
        
    }
    
    
    @IBAction func goBackPressed(_ sender: UIButton) {
    }
    
    
    
    
    private func recordSound(){
        
        soundRecorder.recordSound()
        
        
        ///recorderConductor.startConductingRecording()

        
    }
    
    private func stopRecording(){
        
        soundRecorder.stopRecording()
        ///recorderConductor.stopConductingRecording()
        
    }
    
    
    
    private func playSound(isProcessed:Bool){
        
        soundPlayer.playSound(isProcessed:isProcessed)
        
    }
    

    
    private func stopPlaying(){
        
        soundPlayer.stopPlaying()
    }
    
    
    
    @IBAction func processSwitchChanged(_ sender: UISwitch) {
        
        isProcessed=sender.isOn
        
       print("PROCESSED: \(isProcessed)")
        
        if(isProcessed){
            valueLabel.text = "Processor ON"
        }else{
            valueLabel.text = "Processor OFF"
        }
    }
    

}
