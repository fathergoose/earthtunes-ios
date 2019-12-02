//
//  SoundFile.swift
//  EarthTunes
//
//  Created by Al Ilseman on 12/2/19.
//  Copyright © 2019 Listening-To-The-Solid-Earth. All rights reserved.
//

import Foundation
import AVKit


struct SoundFile {
    var url: URL
    var sonification: Sonification
    
    init(sonification: Sonification) {
        url = URL(fileURLWithPath: NSTemporaryDirectory().appending("sound.wav"))
        self.sonification = sonification
    }


    func saveFile() throws {
        let samples = sonification.samples
        let sample_rate = sonification.sampleRate()

        let outputFormatSettings = [
            AVFormatIDKey:kAudioFormatLinearPCM,
            AVLinearPCMBitDepthKey:32,
            AVLinearPCMIsFloatKey: false,
            AVLinearPCMIsBigEndianKey: false,
            AVSampleRateKey: sample_rate,
            AVNumberOfChannelsKey: 1
            ] as [String : Any]

        var audioFile: AVAudioFile
        do {
            audioFile = try AVAudioFile(
                forWriting: self.url,
                settings: outputFormatSettings,
                commonFormat: AVAudioCommonFormat.pcmFormatInt32,
                interleaved: false
            )
        } catch let error as NSError {
            throw error
        }

        let bufferFormat = AVAudioFormat(settings: outputFormatSettings)
        let outputBuffer = AVAudioPCMBuffer(pcmFormat: bufferFormat!, frameCapacity: AVAudioFrameCount(samples.count))
        for i in 0..<samples.count {outputBuffer!.int32ChannelData!.pointee[i] = Int32(samples[i])}
        outputBuffer?.frameLength = AVAudioFrameCount(samples.count)

        do {
            try audioFile.write(from: outputBuffer!)
        } catch {
            print("Error writing audio file")
        }
    }
    
}
