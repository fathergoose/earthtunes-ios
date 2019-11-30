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
    
    
    init() {
        let request = EventRequest()
        
        URLSession.shared.dataTask(with: request.url()!) { (data, response, error) in
            do {
                guard let data = data else {return}
                let seismicEvent = Event(responseData: data)
                let sonification = Sonification(seismicSamples: seismicEvent.data)
                
                do {
                    try saveFile(
                        samples: sonification.soundSamples,
                        sample_rate: seismicEvent.sampleRate! * sonification.speedFactor
                    )
                }
                catch { print("Problems") }

                
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
