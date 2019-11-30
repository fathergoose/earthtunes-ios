//
//  DataManagement.swift
//  EarthTunes
//
//  Created by Al Ilseman on 11/27/19.
//  Copyright © 2019 Listening-To-The-Solid-Earth. All rights reserved.
//

import Foundation
import AVKit

let url = URL(fileURLWithPath: NSTemporaryDirectory().appending("sound.wav"))
let ud = UserDefaults.standard

/*
func saveEvents(events: [Event]) {
    let archivedObject = NSKeyedArchiver.archivedData(withRootObject: events as NSArray)
    ud.set(archivedObject, forKey: "Events")
    ud.synchronize()
}

func retrieveEvents() -> [Event]? {
    if let unarchivedObject = ud.object(forKey: "Events") as? NSData {
        return (NSKeyedUnarchiver.unarchiveObject(with: unarchivedObject as Data) as? [Event])!
    }
    return nil
}

func saveFavorites(events: [Event]) {
    let archivedObject = NSKeyedArchiver.archivedData(withRootObject: events as NSArray)
    ud.set(archivedObject, forKey: "Favorites")
    ud.synchronize()
}

func retrieveFavorites() -> [Event]? {
    if let unarchivedObject = ud.object(forKey: "Favorites") as? NSData {
        return (NSKeyedUnarchiver.unarchiveObject(with: unarchivedObject as Data) as? [Event])!
    }
    return nil
}
*/

func saveFile(samples: [Float64], sample_rate: Float64) throws {

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
            forWriting: url,
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
