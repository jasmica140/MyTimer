//
//  AppDelegate.swift
//  MyTimer
//
//  Created by Jasmine Micallef on 29/03/2023.
//

import Foundation
import UIKit
import AVFAudio

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.defaultToSpeaker, .mixWithOthers])
                print("Playback OK")
                try AVAudioSession.sharedInstance().setActive(true)
                print("AVAudioSession is Active")
                UIApplication.shared.beginReceivingRemoteControlEvents()
            } catch {
                print(error)
            }
            return true
        }
}
