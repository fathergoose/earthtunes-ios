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



class EventDownloader: ObservableObject {
    var soundFile: SoundFile?
    @Published var status = "unsent"
    var request: EventRequest
    
    init() {
        let defaultStartTime = "2019-05-30T09:00:00"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        self.request = EventRequest(startTime: dateFormatter.date(from:defaultStartTime)!)
    }
    
    
    func getAndSave() {
        status = "sending..."
        URLSession.shared.dataTask(with: request.url()!) { (data, response, error) in
            do {
                DispatchQueue.main.async {
                    self.status = "received"
                }
                guard let data = data else {return}
                let seismicEvent = SeismicEvent(eventRequest: self.request, responseData: data)
                
                DispatchQueue.main.async {
                    self.status = "parsed"
                }
                let sonification = Sonification(seismicEvent: seismicEvent)
                
                DispatchQueue.main.async {
                    self.status = "sonified"
                }
                self.soundFile = SoundFile(sonification: sonification)


                
                do {
                    try self.soundFile!.saveFile()
                    DispatchQueue.main.async {
                        self.status = "saved"
                    }
                    
                }
                catch { print("Problems") }

//                var sound: AVAudioPlayer?
//
//                do {
//                    sound = try AVAudioPlayer(contentsOf: self.soundFile!.url)
//                    print("sound: ", sound!)
//                    sound?.play()
//                    DispatchQueue.main.async {
//                        self.status = "playing"
//
//                    }
//                } catch {
//                    // couldn't load file :(
//                }
//
//                DispatchQueue.main.async {
//                    self.soundFile = sound
//                }
            } catch {
                print("Error decoding JSON: ", error)
            }
        }.resume()
    }
}
