//
//  PushNotifications.swift
//  MyTimer
//
//  Created by Jasmine Micallef on 28/03/2023.
//

import Foundation

import UIKit
import UserNotifications
import AudioToolbox.AudioServices
import AVFoundation

final class PushNotifications {
    
    static let shared = PushNotifications()
    private init() {}

    public func checkForPermission(date: Date) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus{
            case .authorized:
                self.dispatchNotification(date: date)
            case .denied:
                return
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
                    if didAllow {
                        self.dispatchNotification(date: date)
                    }
                }
            default:
                return
            }
        }
    }
    
    public func dispatchNotification(date: Date) {
        let title = "Timer Finished!"
        let body = ""
        
        let calendar = Calendar.current
        let hours = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)

        let notificationCenter = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.categoryIdentifier = "timer"

        var dateComponents = DateComponents(calendar: calendar, timeZone: TimeZone.current)
        dateComponents.hour = hours
        dateComponents.minute = minutes
        dateComponents.second = seconds
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: "timer-\(date))", content: content, trigger: trigger)
    
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
        
        notificationCenter.removeAllDeliveredNotifications()
        notificationCenter.add(request)
    }
}

