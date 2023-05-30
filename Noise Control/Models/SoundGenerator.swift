//
//  SoundGenerator.swift
//  Noise Control
//
//  Created by Piotr Narecki on 03/04/2023.
//

import Foundation
import AudioUnit
import AVFoundation



class SoundGenerator: NSObject {
    
    var frequency: Float=0.0
    
    
//    func generateSound(frequency:Float){
//
//        print("generating \(String(frequency))")
//
//    }
    
    var auAudioUnit: AUAudioUnit! = nil     // placeholder for RemoteIO Audio Unit
    
    var avActive     = false             // AVAudioSession active flag
    var audioRunning = false             // RemoteIO Audio Unit running flag
    
    var sampleRate : Double = 44100.0    // typical audio sample rate
    
    var f0  =    880.0              // default frequency of tone:   'A' above Concert A
    var v0  =  16383.0              // default volume of tone:      half full scale
    
    var toneCount : Int32 = 0       // number of samples of tone to play.  0 for silence
    
    private var phY =     0.0       // save phase of sine wave to prevent clicking
    private var interrupted = false     // for restart from audio interruption notification
    
    
    
    func setFrequency(freq : Double) {  // audio frequencies below 500 Hz may be
        f0 = freq                       //   hard to hear from a tiny iPhone speaker.
    }
    
    func setToneVolume(vol : Double) {  // 0.0 to 1.0
        v0 = vol * 32766.0
    }
    
    func setToneTime(t : Double) {
        toneCount = Int32(t * sampleRate);
    }
    
    func enableSpeaker() {
        
        if audioRunning {
            
//            print("returned")
            return
            
        }           // return if RemoteIO is already running
        
        
        
        do {        // not running, so start hardware
            
            let audioComponentDescription = AudioComponentDescription(
                componentType: kAudioUnitType_Output,
                componentSubType: kAudioUnitSubType_RemoteIO, // For output to the local sound system
                componentManufacturer: kAudioUnitManufacturer_Apple,
                componentFlags: 0,
                componentFlagsMask: 0 )
            
            if (auAudioUnit == nil) {
                
                auAudioUnit = try AUAudioUnit(componentDescription: audioComponentDescription)
                
                let bus0 = auAudioUnit.inputBusses[0]
                
                let audioFormat = AVAudioFormat(
                    commonFormat: AVAudioCommonFormat.pcmFormatInt16,   // short int samples
                    sampleRate: Double(sampleRate),
                    channels:AVAudioChannelCount(2),
                    interleaved: true )                                 // interleaved stereo
                
                try bus0.setFormat(audioFormat ?? AVAudioFormat())  //      for speaker bus
                
                auAudioUnit.outputProvider = { (    //  AURenderPullInputBlock?
                    actionFlags,
                    timestamp,
                    frameCount,
                    inputBusNumber,
                    inputDataList ) -> AUAudioUnitStatus in
                    
                    self.fillSpeakerBuffer(inputDataList: inputDataList, frameCount: frameCount)
                    return(0)
                }
            }
            
            auAudioUnit.isOutputEnabled = true
            toneCount = 0
            
            try auAudioUnit.allocateRenderResources()  //  v2 AudioUnitInitialize()
            try auAudioUnit.startHardware()            //  v2 AudioOutputUnitStart()
            audioRunning = true
            
        } catch /* let error as NSError */ {
            print("error 2 \(error)")
        }
        
        
    }
    
    // helper functions
    
    private func fillSpeakerBuffer(     // process RemoteIO Buffer for output
        inputDataList : UnsafeMutablePointer<AudioBufferList>, frameCount : UInt32 ) {
            let inputDataPtr = UnsafeMutableAudioBufferListPointer(inputDataList)
            let nBuffers = inputDataPtr.count
            if (nBuffers > 0) {
                
                let mBuffers : AudioBuffer = inputDataPtr[0]
                let count = Int(frameCount)
                
                // Speaker Output == play tone at frequency f0
                if (   self.v0 > 0)
                    && (self.toneCount > 0 )
                {
                    // audioStalled = false
                    
                    var v  = self.v0 ; if v > 32767 { v = 32767 }
                    let sz = Int(mBuffers.mDataByteSize)
                    
                    var a  = self.phY        // capture from object for use inside block
                    let d  = 2.0 * Double.pi * self.f0 / self.sampleRate     // phase delta
                    
                    let bufferPointer = UnsafeMutableRawPointer(mBuffers.mData)
                    if var bptr = bufferPointer {
                        for i in 0..<(count) {
                            let u  = sin(a)             // create a sinewave
                            a += d ; if (a > 2.0 * Double.pi) { a -= 2.0 * Double.pi }
                            let x = Int16(v * u + 0.5)      // scale & round
                            
                            if (i < (sz / 2)) {
                                bptr.assumingMemoryBound(to: Int16.self).pointee = x
                                bptr += 2   // increment by 2 bytes for next Int16 item
                                bptr.assumingMemoryBound(to: Int16.self).pointee = x
                                bptr += 2   // stereo, so fill both Left & Right channels
                            }
                        }
                    }
                    
                    self.phY = a                   // save sinewave phase
                    self.toneCount -= Int32(frameCount)   // decrement time remaining
                    
                    
                } else {
                    // audioStalled = true
                    memset(mBuffers.mData, 0, Int(mBuffers.mDataByteSize))  // silence
                }
            }
        }
    
    
    
    func stop() {
        if (audioRunning) {
            auAudioUnit.stopHardware()
            audioRunning = false
        }
    }
    
    var lenght = 10
    var iterator = 0
    var timer = Timer()

    var myFrequencyArray = [Double]()

    
    func generateSequence(){ // add parameters
        

        myFrequencyArray.append(800.0)
        myFrequencyArray.append(1300.0)
        myFrequencyArray.append(1500.0)
        myFrequencyArray.append(1800.0)
        myFrequencyArray.append(2300.0)
        myFrequencyArray.append(2500.0)
        myFrequencyArray.append(2800.0)
        myFrequencyArray.append(3300.0)
        
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    
    
    @objc func updateTimer(){
        
        
        if iterator < myFrequencyArray.count {
            let freq = myFrequencyArray[iterator]
            //generateSingleFrequency(frequency:freq)
            generateFourFrequency(freq1: freq*1, freq2: freq+550, freq3: freq-300, freq4: freq*4+60)

            
            iterator+=1
        }else{
            
            timer.invalidate()
            stop()
        }
    
    }
    
    
    
    func generateSingleFrequency(frequency:Double){
        
                print("\(frequency) Hz")
        setFrequency(freq: Double(frequency))
        setToneVolume(vol: 50)
        enableSpeaker()
        setToneTime(t: 20000)
        
        
        
    }
    
    func generateFourFrequency(freq1:Double,freq2:Double,freq3:Double,freq4:Double){
        
        print("multiple")
        generateSingleFrequency(frequency: freq1)
        generateSingleFrequency(frequency: freq2)
        generateSingleFrequency(frequency: freq3)
        generateSingleFrequency(frequency: freq4)

        
        
        
    }
    
    
   
    
    
    
    
    
}


