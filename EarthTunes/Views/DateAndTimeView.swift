//
//  DateAndTimeView.swift
//  EarthTunes
//
//  Created by Al Ilseman on 1/26/20.
//  Copyright © 2020 Listening-To-The-Solid-Earth. All rights reserved.
//

import SwiftUI

struct DateAndTimeView: View {
    @ObservedObject var downloader: EventDownloader
    @State var displayDatePicker = false
    @State var displayTimePicker = false
    
    
    var dateRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .year, value: -20, to: Date())!
        let max = Date()
        return min...max
    }
    
    func dateString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    func timeString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: date)
    }
    
    var body: some View {
        VStack (alignment: .leading){
            Text("Date and Time").font(.headline).padding()
            HStack {

                    Text(dateString(downloader.request.startDate)).padding()
                
                Spacer()
                Button(action: {
                    withAnimation {
                        self.displayTimePicker = false
                        self.displayDatePicker.toggle()
                    }
                }) {
                    Image(systemName: "chevron.right.circle")
                        .imageScale(.large)
                        .rotationEffect(.degrees(displayDatePicker ? 90 : 0))
                        .scaleEffect(displayDatePicker ? 1.5 : 1)
                        .padding()
                }
            }
            .padding()
            
            if (displayDatePicker) {
                DatePicker(
                    "Event Start Date",
                    selection: $downloader.request.startDate,
                    in: dateRange,
                    displayedComponents: .date
                ).labelsHidden()
            }
            HStack {
                Text(timeString(downloader.request.startTime)).padding()
                Spacer()
                Button(action: {
                    withAnimation {
                        self.displayDatePicker = false
                        self.displayTimePicker.toggle()
                    }
                }) {
                    Image(systemName: "chevron.right.circle")
                        .imageScale(.large)
                        .rotationEffect(.degrees(displayTimePicker ? 90 : 0))
                        .scaleEffect(displayTimePicker ? 1.5 : 1)
                        .padding()
                }
            }
            .padding()
            if (displayTimePicker) {
                DatePicker(
                    "Event Start Time",
                    selection: $downloader.request.startTime,
                    in: dateRange,
                    displayedComponents: .hourAndMinute
                ).labelsHidden()
            }
        }
    }
}

struct DateAndTimeView_Previews: PreviewProvider {
    static var previews: some View {
        DateAndTimeView(downloader: EventDownloader())
    }
}
