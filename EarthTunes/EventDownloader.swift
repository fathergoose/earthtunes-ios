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
    var request = EventRequest()
    
    
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
            }
        }.resume()
    }
}
