//
//  Data.swift
//  EarthTunes
//
//  Created by Al Ilseman on 12/2/19.
//  Copyright © 2019 Listening-To-The-Solid-Earth. All rights reserved.
//

import Foundation
let twentyYearsAgo = Calendar.current.date(byAdding: .year, value: -20, to: Date())!
let last20Years = DateInterval(start: twentyYearsAgo, end: Date())
let appLocations: [Location] = [
    Location(
        name: "JP-JOW",
        stations: [
            last20Years: SeismicStation(
                networkCode: "JP",
                stationCode: "JOW",
                locationCode: "--",
                channel: Channels.BHZ
        )
    ]),
    Location(
        name: "GT-VNDA",
        stations: [
            last20Years: SeismicStation(
                networkCode: "GT",
                stationCode: "VNDA",
                locationCode: "00",
                channel: Channels.BHZ
        )
    ]),
    Location(
        name: "GE_SNAA",
        stations: [
            last20Years: SeismicStation(
                networkCode: "GE",
                stationCode: "SNAA",
                locationCode: "--",
                channel: Channels.BHZ
        )
    ]),
    Location(
        name: "NZ-KHZ",
        stations: [
            last20Years: SeismicStation(
                networkCode: "NZ",
                stationCode: "KHZ",
                locationCode: "10",
                channel: Channels.HHZ
        )
    ]),
    Location(
        name: "San Pablo, Spain",
        stations: [
            last20Years: SeismicStation(
                networkCode: "IU",
                stationCode: "PAB",
                locationCode: "00",
                channel: Channels.BHZ
        )
    ]),
    Location(
        name: "Qiongzhong, Hainan, China",
        stations: [
            last20Years: SeismicStation(
                networkCode: "IC",
                stationCode: "QIZ",
                locationCode: "10",
                channel: Channels.HHZ
        )
    ]),
    Location(
        name: "Lusaka Zambia",
        stations: [
            last20Years: SeismicStation(
                networkCode: "IU",
                stationCode: "LSZ",
                locationCode: "10",
                channel: Channels.BHZ
        )
    ]),
    Location(
        name: "Pinon Flat, California, USA",
        stations: [
            last20Years: SeismicStation(
                networkCode: "II",
                stationCode: "PFO",
                locationCode: "10",
                channel: Channels.BHZ
        )
    ]),
    Location(
        name: "Mahe, Seychelles",
        stations: [
            last20Years: SeismicStation(
                networkCode: "II",
                stationCode: "MSEY",
                locationCode: "10",
                channel: Channels.BHZ
        )
    ]),
    Location(
        name: "Glen Almond, Quebec, Canada",
        stations: [
            last20Years: SeismicStation(
                networkCode: "CN",
                stationCode: "GAC",
                locationCode: "--",
                channel: Channels.BHZ
        )
    ]),
    Location(
        name: "Mahe, Seychelles",
        stations: [
            last20Years: SeismicStation(
                networkCode: "II",
                stationCode: "MSEY",
                locationCode: "10",
                channel: Channels.BHZ
        )
    ]),
    Location(
        name: "Casey, Antarctica",
        stations: [
            last20Years: SeismicStation(
                networkCode: "IU",
                stationCode: "CASY",
                locationCode: "10",
                channel: Channels.BHZ
        )
    ]),
    Location(
        name: "Greyslake, IL",
        stations: [
            DateInterval(start: twentyYearsAgo, end: dateFromString("2019-02-01")): SeismicStation(
                networkCode: "TA",
                stationCode: "L44A",
                locationCode: "--",
                channel: Channels.BHZ
            ),
            DateInterval(start: dateFromString("2019-02-01"), end: Date()): SeismicStation(
                networkCode: "NW",
                stationCode: "L44A",
                locationCode: "00",
                channel: Channels.HHZ
            )
    ])
]


func dateFromString(_ str: String) -> Date {
    let dateFormat = "yyyy-MM-dd"

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat

    return dateFormatter.date(from: str)!
}



//  SeismicStation(networkCode: "TA", stationCode: "L44A", locationCode: nil, channel: Channels.BHZ, displayName: "Greyslake, IL"), // < Feb '19
//  SeismicStation(networkCode: "NW", stationCode: "L44A", locationCode: nil, channel: Channels.HHZ, displayName: "Greyslake, IL"), // > Feb '19

/*
 Finding 10 stations was much harder than I thought primarily because stations get upgrades that change the channel or location codes, or they do not have continuous data for a decent time period (at least a decade).  Here is a list that will work:

 Suzan 11:39 PM
 
 net sta loc ch
 JP  JOW -- BHZ
 GT  VNDA 00 BHZ
 GE  SNAA -- BHZ
 NZ  KHZ 10 HHZ
 IU  PAB 00 BHZ
 IC  QIZ 10 HHZ
 IU  LSZ 10 BHZ
 II  PFO 10 BHZ
 II  MSEY 10 BHZ
 CN  GAC -- BHZ
 IU  CASY 10 BHZ
 TA  L44A -- BHZ
 There are 12 stations on the list. The first column is network code, the 2nd is stations code/name, the 3rd is location code, the 4th is channel name.  The last one (L44A in Ryerson) only works through the end of February 2019. For data after March 2019, we need to use
 NW L44A 00 HHZ
 For each of these stations the sampling rate is different and would need to be read in from the header line of each text file one gets from the web service.

 */
