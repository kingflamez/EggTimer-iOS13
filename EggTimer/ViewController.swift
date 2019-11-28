//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet var desc: UILabel!
    @IBOutlet var readyProgress: UIProgressView!
    
    var player: AVAudioPlayer!
    
    let softTime = 5
    let mediumTime = 7
    let hardTime = 12
    
    let eggTimes = ["Soft": 5, "Medium": 7, "Hard": 12]
    
    
    var timer:Timer?
    var timeLeft:Int?
    var totalTime:Int?
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness: String = sender.currentTitle!
        

        timer?.invalidate()
        timer = nil
        
        readyProgress.progress = 0
        
        timeLeft = eggTimes[hardness]!
        totalTime = eggTimes[hardness]!
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)

        desc.text = "Frying Egg"
        
    }
    
    
    @objc func fireTimer() {
        readyProgress.isHidden = false
        timeLeft! -= 1
    
        let progress: Float = Float(totalTime!-timeLeft!) / Float(totalTime!)
        
        readyProgress.progress = progress
        
        if timeLeft! <= 0 {
            desc.text = "Your egg is done"
            timer?.invalidate()
            timer = nil
            playSound()
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
            
        } catch let error {

            print(error.localizedDescription)
        }
                
    }
    
    
    
}
