//
//  Location.swift
//  EarthTunes
//
//  Created by Al Ilseman on 12/13/19.
//  Copyright © 2019 Listening-To-The-Solid-Earth. All rights reserved.
//

import Foundation

struct Location {
    let name: String
    let stations: Dictionary<DateInterval,SeismicStation>
    
    
    func station(startTime: Date) -> SeismicStation? {
        //return stations.first(where: { (interval, station) in interval.contains(startTime) })
        if let station = stations.first(where: { $0.key.contains(startTime) }) {
            return station.value
        }
        return nil
    }
}
