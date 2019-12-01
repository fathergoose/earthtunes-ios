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
    @Published var sound: AVAudioPlayer?
    var request: EventRequest
    
    init() {
        let defaultStartTime = "2019-05-30T09:00:00"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        self.request = EventRequest(startTime: dateFormatter.date(from:defaultStartTime)!)
    }
    
    
    func getAndPlay() { 
        URLSession.shared.dataTask(with: request.url()!) { (data, response, error) in
            do {
                guard let data = data else {return}
                let seismicEvent = SeismicEvent(eventRequest: self.request, responseData: data)
                let sonification = Sonification(seismicEvent: seismicEvent)
                
                do {
                    let rate = seismicEvent.sampleRate! * sonification.speedFactor
                    print("rate: ", rate)
                    try saveFile(
                        samples: sonification.soundSamples,
                        sample_rate: rate
                    )
                }
                catch { print("Problems") }

                
                var sound: AVAudioPlayer?
                
                do {
                    sound = try AVAudioPlayer(contentsOf: url)
                    print("sound: ", sound!)
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
