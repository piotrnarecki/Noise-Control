//
//  SoundProcessor.swift
//  Noise Control
//
//  Created by Piotr Narecki on 09/06/2023.
//

import Foundation
import AVFAudio


class SoundProcessor{
    
    func processSound(){

        print("INSIDE SOUND PROCESSOR")
        
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let originalFilename = documentPath.appendingPathComponent("original.m4a")
        let processedFilename = documentPath.appendingPathComponent("processed.m4a")



//https://stackoverflow.com/questions/54308068/how-to-generate-phase-inverse-audio-file-from-input-audio-file-in-swift

        do {
            //    let inFile: AVAudioFile = try AVAudioFile(forReading: URLFor(filename: "my_file.caf")!)

            let inFile: AVAudioFile = try AVAudioFile(forReading: originalFilename)

            let format: AVAudioFormat = inFile.processingFormat
            let frameCount: AVAudioFrameCount = UInt32(inFile.length)

            let outSettings = [AVNumberOfChannelsKey: format.channelCount,
                               AVSampleRateKey: format.sampleRate,
                               AVLinearPCMBitDepthKey: 16,
                               AVFormatIDKey: kAudioFormatMPEG4AAC] as [String : Any]



            let outFile: AVAudioFile = try AVAudioFile(forWriting: processedFilename, settings: outSettings)



            let forwardBuffer: AVAudioPCMBuffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: frameCount)!
            
            
            let reverseBuffer: AVAudioPCMBuffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: frameCount)!



            try inFile.read(into: forwardBuffer)
            
            let frameLength = forwardBuffer.frameLength
            reverseBuffer.frameLength = frameLength
            
            let audioStride = forwardBuffer.stride  // krok



            for channelIdx in 0..<forwardBuffer.format.channelCount {
                
                let forwardChannelData = forwardBuffer.floatChannelData?.advanced(by: Int(channelIdx)).pointee
                let reverseChannelData = reverseBuffer.floatChannelData?.advanced(by: Int(channelIdx)).pointee

                var reverseIdx: Int = 0
                
print("CHANNEL ID + \(channelIdx)")
                
                for idx in stride(from: frameLength, to: 0, by: -1) {
                    
                    
//                    memcpy(reverseChannelData?.advanced(by: reverseIdx * audioStride),
//
//                           forwardChannelData?.advanced(by: (Int(idx) * audioStride)),
//
//                           MemoryLayout<Float>.size)
//
//                    reverseIdx += 1
                    
//                    var reversedThingsList = (forwardChannelData?.advanced(by: (Int((idx)) * audioStride)))
                    
                    //TO CZYTAC
                    //https://developer.apple.com/documentation/swift/unsafemutablepointer
                    
                    
                    
                    memcpy(reverseChannelData?.advanced(by: (Int(idx) * audioStride)),
                           
                           forwardChannelData?.advanced(by: (Int((idx)) * audioStride)),
                           
                           MemoryLayout<Float>.size)
                    
                    reverseIdx += 1
                    
                    
                    
                }
            }

//            My naive approach would be: subtract the average (the bias), multiply by -1, add average back in.

            try outFile.write(from: reverseBuffer)
        } catch let error {
            print(error.localizedDescription)
        }



        
        //outfile =

    }
    
    
    
    
    
    
}
