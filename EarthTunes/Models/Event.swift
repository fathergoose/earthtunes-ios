//
//  Event.swift
//  EarthTunes
//
//  Created by Al Ilseman on 11/29/19.
//  Copyright © 2019 Listening-To-The-Solid-Earth. All rights reserved.
//

import Foundation

struct Event {
    var data: [Double]
    var sampleCount: Double?
    var sampleRate: Double?
    
    
    init(responseData: Data) {
        let str = String(data: responseData, encoding: String.Encoding.utf8)
        var lines = str!.split { $0.isNewline }
        let metadata = lines[0]
        lines.removeFirst()
        lines.removeLast()
        
        sampleCount = Double(metadata.split(separator: " ")[2])
        sampleRate = Double(metadata.split(separator: " ")[4])
        data = lines.map{ ($0 as NSString).doubleValue }
    }
}

