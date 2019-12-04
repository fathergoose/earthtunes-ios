//
//  Event.swift
//  EarthTunes
//
//  Created by Al Ilseman on 11/29/19.
//  Copyright © 2019 Listening-To-The-Solid-Earth. All rights reserved.
//

import Foundation

struct SeismicEvent {
    var request: EventRequest
    var data: [Double]
    var sampleCount: Double?
    var sampleRate: Double?
    var startTime: Date?
    
    
    init(eventRequest: EventRequest, responseData: Data) {
        request = eventRequest
        print(request.url()!.absoluteString)
        
        let responseString = String(data: responseData, encoding: String.Encoding.utf8)
        print("RESPONSE: ", responseString!)

        var responseLines = responseString!.split { $0.isNewline }
        let metadata = responseLines[0]
        responseLines.removeFirst()
        responseLines.removeLast()
        
        sampleCount = Double(metadata.split(separator: " ")[2])
        sampleRate = Double(metadata.split(separator: " ")[4])
        data = responseLines.map{ ($0 as NSString).doubleValue }
        for i in 0...10 {
            print(data[i])
        }
    }
}

