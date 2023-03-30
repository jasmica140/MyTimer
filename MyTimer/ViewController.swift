//
//  ViewController.swift
//  MyTimer
//
//  Created by Jasmine Micallef on 29/03/2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player:AVAudioPlayer = AVAudioPlayer ()
    override func viewDidLoad() {
        super.viewDidLoad ()
        
        do{
            let audioPath = Bundle.main.path(forResource: "song", ofType: "mp3")
            try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
        }
        catch{
            //PROCESS ERROR
        }
        
        let session = AVAudioSession.sharedInstance ()
        do{
            try session.setCategory (AVAudioSession.Category.playback)
        }
        catch{
        }
        player.play ()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
