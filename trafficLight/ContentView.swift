//
//  ContentView.swift
//  trafficLight
//
//  Created by LIDZIYA KAMYNINA  on 21/02/2024.
//
import SwiftUI

struct ContentView: View {
    @State var showPicker = false
    @State var pickerValue = Date()

    var body: some View {
        VStack {
            Text("Traffic Light app")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(Color.red)
            
            Spacer()
            
            Toggle("Set time", isOn: $showPicker)
                .font(.title2)
                .padding(10)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
        }

            
            if showPicker {
                           TrafficLightView(pickerValue: $pickerValue)
                       } else {
                           Text("No time set")
                               .fontWeight(.light)
                       }
                   }
               }
           

           struct TrafficLightView: View {
               @Binding var pickerValue: Date

               var body: some View {
                   VStack {
                       trafficLight(for: pickerValue)
                    
                       DatePicker("", selection: $pickerValue, displayedComponents: .hourAndMinute)
                           .labelsHidden()
                           .datePickerStyle(WheelDatePickerStyle())
                           .environment(\.locale, Locale(identifier: "en_GB"))
                           .onChange(of: pickerValue) { newValue in
                               pickerValue = setTime(for: newValue)//everytime new value is chosen it checks if its time when traffic light operates
                           }
                   }
               }
        
        private func trafficLight(for date: Date) -> some View {
            let minute = Calendar.current.component(.minute, from: date)
            let color = lightColor(for: minute) //chooses color based on the minute
                
                return Circle()
                    .foregroundColor(color)
                    .frame(width: 100, height: 100)
            }
        }

func setTime(for date: Date) -> Date {
    let hour = Calendar.current.component(.hour, from: date)
    
    if !(hour >= 6) { //if chosen time is between midnight and 5.59 am, time automaticaly sets it to 6.00 am
           let minimumAllowedTime = Calendar.current.date(bySettingHour: 6, minute: 0, second: 0, of: Date()) ?? Date()
           return minimumAllowedTime
       }
       return date
   }

private func lightColor(for minute: Int) -> Color {
    let greenMinutes = [0, 1, 7, 8, 14, 15, 21, 22, 28, 29, 35, 36, 42, 43, 49, 50, 55, 56] // green lasts for 2 minutes
    let redMinutes = [3, 4, 5, 10, 11, 12, 17, 18, 19, 24, 25, 26, 31, 32, 33, 38, 39, 40, 45, 47, 47, 52, 53, 54, 58, 59] // red lasts for 3 minutes

    if greenMinutes.contains(minute) {
        return .green
    } else if redMinutes.contains(minute) {
        return .red
    } else {
        return .yellow //the remaining minutes are assigned to yellow color
    }
}


        
    
   
