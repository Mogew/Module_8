//
//  ViewController.swift
//  Module_8_EggApp
//
//  Created by Renat on 05.04.2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTimes = ["Soft": 30, "Medium": 40, "Hard": 720]
    var timer = Timer()
    var player: AVAudioPlayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func playSound() {
        guard let path = Bundle.main.path(forResource: "alarm_sound", ofType: "mp3") else {
            return
        }
        let url = URL(fileURLWithPath: path)
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            player = try AVAudioPlayer(contentsOf: url)
            player?.volume = 0.2
            player?.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        // getting values(requered seconds) from dictionary
        let hardness = sender.titleLabel?.text
        let buttonValue = eggTimes[hardness!]
        labelText.text = hardness!
        // some calculations for progress bar update
        var progress: Float = 1.0
        let progressStep: Float = 1.0 / Float(buttonValue!)
        
        
        var timerCount = buttonValue!
        // timer with 1 second interval
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            print("\(timerCount) seconds.")
            timerCount -= 1
            // update progress bar
            self.progressBar.progress = progress
            progress -= progressStep
            // end life time of timer after it equals 0
            if timerCount < 0 {
                timer.invalidate()
                self.labelText.text = "Done!"
                self.progressBar.progress = 0.0
                self.playSound()
            }
        }
        
    }
}

