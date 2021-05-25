//  Egg Timer

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLeftBar: UIProgressView!
    @IBOutlet weak var timeLeft: UILabel!
    
    let eggTime = ["Soft" : 3, "Medium" : 420, "Hard" : 720]
    var timeSet = 0
    var timePassed = 0
    var timer = Timer()
    var hardness = ""
    var player : AVAudioPlayer!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        hardness = sender.currentTitle!
        timeSet = eggTime[hardness]!
        
        timeLeftBar.progress = 0.0
        timePassed = 0

        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if timePassed < timeSet {
            print("\(timeSet - timePassed) seconds left.")
            timeLeft.text = "\(timeSet - timePassed) seconds left (\(round(timeLeftBar.progress*100)/100)%)"
            
            timePassed += 1
            timeLeftBar.progress = Float(timePassed) / Float(timeSet)
            titleLabel.text = "Cooking \(hardness) egg..."
        }
        else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            timeLeft.text = "100%"
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
}
