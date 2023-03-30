//
//  Content-ViewModel.swift
//  MyTimer
//
//  Created by Jasmine Micallef on 22/03/2023.
//

import Foundation
import UserNotifications
import AudioToolbox.AudioServices

extension ContentView{ //so view model is only available in content view

    final class ViewModel: ObservableObject{
        
        //initialise
        @Published var isActive = false
        @Published var showingAlert = false
        @Published var keepVibrate = true
        @Published var time:String = "00:00:00"
        @Published var endTime:Date = Date()
        @Published var hours:Int = 0{
            didSet{
                var components = DateComponents()
                components.hour = hours
                components.minute = minutes
                components.second = seconds
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm:ss"
                let Time = Calendar.current.date(from: components)
                self.time = dateFormatter.string(from: Time!)            }
        }
        @Published var minutes:Int = 0{
            didSet{
                var components = DateComponents()
                components.hour = hours
                components.minute = minutes
                components.second = seconds
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm:ss"
                let Time = Calendar.current.date(from: components)
                self.time = dateFormatter.string(from: Time!)            }
        }
        @Published var seconds:Int = 0{
            didSet{
                var components = DateComponents()
                components.hour = hours
                components.minute = minutes
                components.second = seconds
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm:ss"
                let Time = Calendar.current.date(from: components)
                self.time = dateFormatter.string(from: Time!)
            }
        }
        
        private var runCount = 0.0
        private var initialHr = 0
        private var initialMin = 0
        private var initialSec = 0

        func start(hours: Int, minutes: Int, seconds: Int){
            self.initialHr = hours
            self.initialMin = minutes
            self.initialSec = seconds
            self.endTime = Date()
            self.isActive = true
            self.keepVibrate = true
            self.runCount = 0.0
            self.endTime = Calendar.current.date(byAdding: .hour, value: hours, to: endTime)!
            self.endTime = Calendar.current.date(byAdding: .minute, value: minutes, to: endTime)!
            self.endTime = Calendar.current.date(byAdding: .second, value: seconds, to: endTime)!
            PushNotifications.shared.checkForPermission(date: endTime+runCount)
        }
        
        @objc func vibrate(timer: Timer){
            
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            self.runCount += 1.0
            if !self.keepVibrate{
                timer.invalidate()
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            }
        }
        
        func pause(){
            self.isActive = false
            
            var components = DateComponents()
            components.hour = hours
            components.minute = minutes
            components.second = seconds
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            let Time = Calendar.current.date(from: components)
            self.time = dateFormatter.string(from: Time!)
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        }

        func reset(){
            self.hours = initialHr
            self.minutes = initialMin
            self.seconds = initialSec
            self.isActive = false

            var components = DateComponents()
            components.hour = hours
            components.minute = minutes
            components.second = seconds
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            let Time = Calendar.current.date(from: components)
            self.time = dateFormatter.string(from: Time!)
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        }

        func updateCountDown(){
            guard isActive else { return }
            
            let now = Date()

            let Diff = endTime.timeIntervalSince1970 - now.timeIntervalSince1970 

            if Diff <= 0{
                self.isActive = false
                self.time = "00:00:00"
                self.showingAlert = true
                Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(vibrate), userInfo: nil, repeats: true)
                HapticsManager.shared.vibrate(for: .success)
                return
            }
            
            let hms = Date(timeIntervalSince1970: Diff)

            let calendar = Calendar.current
            let hours = calendar.component(.hour, from: hms) - 1
            let minutes = calendar.component(.minute, from: hms)
            let seconds = calendar.component(.second, from: hms)

            self.hours = hours
            self.minutes = minutes
            self.seconds = seconds
            
            var components = DateComponents()
            components.hour = hours
            components.minute = minutes
            components.second = seconds
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            let Time = Calendar.current.date(from: components)
            self.time = dateFormatter.string(from: Time!)
        }
    }
}
