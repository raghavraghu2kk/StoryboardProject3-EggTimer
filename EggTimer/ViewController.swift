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
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    var player : AVAudioPlayer!
    var timer = Timer()
    let eggTimes = ["Soft" : 3, "Medium" : 4, "Hard" : 7]
    var totalTime = 0
    var secondsPassed = 1
    
    override func viewDidLoad() {
        progressView.progress = 0.0
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        
        let hardness = (sender.currentTitle)!
        
        totalTime = eggTimes[hardness]!
        progressView.progress = 0.0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateTimer() {
        if secondsPassed <= totalTime {
            print(secondsPassed)
            let percentageProgress = (Float(secondsPassed) / Float(totalTime))
            print(percentageProgress)
            progressView.progress = Float(percentageProgress)
            secondsPassed += 1
        } else {
            timer.invalidate()
            secondsPassed = 0
            titleLabel.text = "Done!"
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4){
                self.titleLabel.text = "How would you like your eggs?"
            }
        }
    }

}
