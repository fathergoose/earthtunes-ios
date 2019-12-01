//
//  Sonification.swift
//  EarthTunes
//
//  Created by Al Ilseman on 11/29/19.
//  Copyright © 2019 Listening-To-The-Solid-Earth. All rights reserved.
//

import Foundation

struct Sonification {
    var event: SeismicEvent
    var soundSamples: [Double]
    var speedFactor: Double

    
    
    init(seismicEvent: SeismicEvent) {
        event = seismicEvent
        let halfPi = Double.pi / 2
        let fixedAmp: Double = 5e-5
        speedFactor = 800
        let ex = pow(2.0, 31.0)

        let multiplier = ex / halfPi

        soundSamples = event.data.map{
            atan( ( $0 )/fixedAmp) * multiplier
        }
        
        for i in 0...10 {
            print(soundSamples[i])
        }
    }
}
