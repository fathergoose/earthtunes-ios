//
//  SoundFile.swift
//  EarthTunes
//
//  Created by Al Ilseman on 12/2/19.
//  Copyright © 2019 Listening-To-The-Solid-Earth. All rights reserved.
//

import Foundation
import AVKit


class SoundFile {
    var tempURL: URL
    var exportURL: URL?
    var sonification: Sonification
    
    init(sonification: Sonification) {
        self.sonification = sonification
        let req = sonification.event.request
        let filename = "\(appLocations[req.stationIndex].name)-\(req.startDateTimeURLFriendlyString()).wav"
        tempURL = URL(fileURLWithPath: NSTemporaryDirectory().appending(filename))
    }
    // url format = station-start-duration-amplitude-speed.wav
    
    func documentsDirectoryURL() -> String
    {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory,
        .userDomainMask,
        true)[0]
    }

    func saveExportFile() {
        let destUrl = URL(fileURLWithPath: documentsDirectoryURL().appending("/\(tempURL.lastPathComponent)"))
        do {
            try FileManager.default.copyItem(at: tempURL, to: destUrl)
            exportURL = destUrl
            print("no error")
        } catch {
            print("ERROR################")
            print(error)
            print("TEMPURL#################")
            print(tempURL.absoluteString)
        }
    }
    
    func saveTempFile() throws {
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
            print("url: \(self.tempURL)")
            audioFile = try AVAudioFile(
                forWriting: self.tempURL,
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
