//
//  DataService.swift
//  EarthTunes
//
//  Created by Al Ilseman on 11/24/19.
//  Copyright © 2019 Listening-To-The-Solid-Earth. All rights reserved.
//

import Foundation
import AVFoundation
import AudioToolbox
import AudioUnit
import CoreFoundation

let todosEndpoint = "http://service.iris.edu/irisws/timeseries/1/query"


class TodoDownloader: ObservableObject {
    @Published var sound: AVAudioPlayer?
    
    init() {
        let HALFPI = Double.pi / 2
        let fixedAmp: Double = 5e-5
        let speedFactor: Double = 800
        
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "service.iris.edu"
        components.path = "/irisws/timeseries/1/query"

        let queryItemNet = URLQueryItem(name: "net", value: "NW")
        let queryItemStation = URLQueryItem(name: "sta", value: "L44A")
        let queryItemLocation = URLQueryItem(name: "loc", value: "00")
        let queryItemChannel = URLQueryItem(name: "cha", value: "HHZ")
        let queryItemStart = URLQueryItem(name: "starttime", value: "2019-05-30T09:00:00")
        let queryItemDuration = URLQueryItem(name: "duration", value: "7200")
        let queryItemDemean = URLQueryItem(name: "demean", value: "true")
        let queryItemScale = URLQueryItem(name: "scale", value: "auto")
        let queryItemOutput = URLQueryItem(name: "output", value: "ascii1")

        components.queryItems = [
            queryItemNet,
            queryItemStation,
            queryItemLocation,
            queryItemChannel,
            queryItemStart,
            queryItemDuration,
            queryItemDemean,
            queryItemScale,
            queryItemOutput
        ]
        
        URLSession.shared.dataTask(with: components.url!) { (data, response, error) in
            do {
                guard let data = data else {return}
                
                let str = String(data: data, encoding: String.Encoding.utf8)
                var lines = str!.split { $0.isNewline }
                let metadata = lines[0]
                lines.removeFirst()
                lines.removeLast()
                
                let sampleCount = metadata.split(separator: " ")[2]
                let sampleRate = Double(metadata.split(separator: " ")[4])
                
                print(metadata)
                print("Samples: \(sampleCount)")
                print("Rate: \(String(sampleRate!))")


                let ex = pow(2.0, 31.0)
                let numsound = lines.map{
                    ex * atan(($0 as NSString).doubleValue/fixedAmp) / HALFPI
                }

                do {
                    try saveFile(samples: numsound, sample_rate: sampleRate! * speedFactor)
                }
                catch {
                    print("Problems")
                    
                }
                
                print("url: \(url)")

                var sound: AVAudioPlayer?
                
                do {
                    sound = try AVAudioPlayer(contentsOf: url)
                    sound?.play()
                } catch {
                    // couldn't load file :(
                }
                
                
                
                
                
                DispatchQueue.main.async {
                    self.sound = sound
                }
            } catch {
                print("Error decoding JSON: ", error)
            }
        }.resume()
    }
}

extension Array where Element: FloatingPoint {
    mutating func buffer() -> AudioBuffer {
        return AudioBuffer(mNumberChannels: 1, mDataByteSize: UInt32(self.count * MemoryLayout<Element>.size), mData: &self)
    }
}


//               var bytesToWrite = (UInt32(String(sampleCount)) ?? 0) * 2
//                var buffer = numsound.buffer()
//                var audioFile: AudioFileID? = nil
//
//                // varaudioErr OSStatus = noErr
//                let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//
//                // lets create your destination file url
//                let destinationUrl = documentsDirectoryURL.appendingPathComponent("test")
//                print(destinationUrl)
//
////              if FileManager.default.fileExists(atPath: destinationUrl.path) { }
//
//                var streamDescription = AudioStreamBasicDescription()
////              memset(&asbd,0, sizeof(asbd));
//
//                streamDescription.mSampleRate = Double(String(sampleRate)) ?? 0
//                streamDescription.mFormatID = kAudioFormatLinearPCM
//
//                streamDescription.mFormatFlags = kLinearPCMFormatFlagIsSignedInteger | kLinearPCMFormatFlagIsPacked
//
//
//                streamDescription.mBitsPerChannel = 16
//                streamDescription.mChannelsPerFrame = 1
//                streamDescription.mFramesPerPacket = 1
//                streamDescription.mBytesPerFrame = 4
//                streamDescription.mBytesPerPacket = 4
//
//                let audioErr = AudioFileCreateWithURL(
//                    destinationUrl as CFURL,
//                    kAudioFileWAVEType,
//                    &streamDescription,
//                    AudioFileFlags(rawValue: 1),
//                    &audioFile
//                )
//                print(String(audioErr.description))
//                var ioNumBytes = buffer.mDataByteSize
//
//                var stat = AudioFileWriteBytes(audioFile!, false, 0, &ioNumBytes, &buffer)
//
//
//
