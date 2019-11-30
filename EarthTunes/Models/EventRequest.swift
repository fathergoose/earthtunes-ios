//
//  EventRequest.swift
//  EarthTunes
//
//  Created by Al Ilseman on 11/29/19.
//  Copyright © 2019 Listening-To-The-Solid-Earth. All rights reserved.
//

import Foundation

struct EventRequest {
    private var components = URLComponents()

    var net: String = "NW"
    var station: String = "L44A"
    var location: String = "00"
    var channel: String = "HHZ"
    var start: String = "2019-05-30T09:00:00"
    var duration: String = "7200"
    
    
    let demean: String = "true"
    let scale: String = "auto"
    let output: String = "ascii1"
    
    
    
    init() {
        components.scheme = "https"
        components.host = "service.iris.edu"
        components.path = "/irisws/timeseries/1/query"
        components.queryItems = [
            URLQueryItem(name: "net", value: self.net),
            URLQueryItem(name: "sta", value: self.station),
            URLQueryItem(name: "loc", value: self.location),
            URLQueryItem(name: "cha", value: self.channel),
            URLQueryItem(name: "starttime", value: self.start),
            URLQueryItem(name: "duration", value: self.duration),
            URLQueryItem(name: "demean", value: self.demean),
            URLQueryItem(name: "scale", value: self.scale),
            URLQueryItem(name: "output", value: self.output)
        ]
    }
    
    func url() -> URL? {
        return self.components.url
    }

}


