//
//  EventRequest.swift
//  EarthTunes
//
//  Created by Al Ilseman on 11/29/19.
//  Copyright © 2019 Listening-To-The-Solid-Earth. All rights reserved.
//

import Foundation

class EventRequest {
    private var components = URLComponents()

    var net: String = "NW"
    var stationIndex: Int = 0
    var location: String = "00"
    var channel: String = "HHZ"
    var startDate: Date = Date()
    var startTime: Date = Date()
    var duration: String = "7200"
    
    
    var demean: String = "true"
    var scale: String = "auto"
    var output: String = "ascii1"
    
    
    func startDateTimeString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let startTimeString = String(formatter.string(from: self.startTime).split(separator: "T")[1])
        let startDateString = String(formatter.string(from: self.startDate).split(separator: "T")[0])
        let dateTimeString = "\(startDateString)T\(startTimeString)"
        
        return dateTimeString
    }
    
    func url() -> URL? {
        self.build()
        return self.components.url
    }
    
    private func build() -> Void {
        components = URLComponents()
        components.scheme = "https"
        components.host = "service.iris.edu"
        components.path = "/irisws/timeseries/1/query"
        components.queryItems = [
            URLQueryItem(name: "net", value: self.net),
            URLQueryItem(name: "sta", value: stationList[self.stationIndex].networkCode),
            URLQueryItem(name: "loc", value: self.location),
            URLQueryItem(name: "cha", value: self.channel),
            URLQueryItem(name: "starttime", value: self.startDateTimeString()),
            URLQueryItem(name: "duration", value: self.duration),
            URLQueryItem(name: "demean", value: self.demean),
            URLQueryItem(name: "scale", value: self.scale),
            URLQueryItem(name: "output", value: self.output)
        ]
    }

}


