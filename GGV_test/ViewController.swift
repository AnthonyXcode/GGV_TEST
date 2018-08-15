//
//  ViewController.swift
//  GGV_test
//
//  Created by Chan Yun Yuen on 14/8/2018.
//  Copyright © 2018 GGV. All rights reserved.
//

import UIKit
import Repeat

class ViewController: UIViewController {
    
    @IBOutlet var bgView: UIView!
    @IBOutlet weak var infoBtn: UIButton!
    @IBOutlet weak var historyBtn: UIButton!
    @IBOutlet weak var upBtn: UIButton!
    @IBOutlet weak var downBtn: UIButton!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var taskTF: UITextField!
    @IBOutlet weak var timeLab: UILabel!
    
    @IBAction func infoPress(_ sender: Any) {
    }
    
    @IBAction func historyPress(_ sender: Any) {
    }
    
    @IBAction func upPress(_ sender: Any) {
        if (timer == nil) {
          timerModifier(isAdd: true)
          setupTimeLab()
        }
    }
    
    @IBAction func downPress(_ sender: Any) {
        if (timer == nil) {
          timerModifier(isAdd: false)
          setupTimeLab()
        }
    }
    
    @IBAction func startPress(_ sender: Any) {
        if let exsitingTime = timer {
            exsitingTime.pause()
            timer = nil
        } else {
            timer = Repeater(interval: .seconds(1), observer: {_ in
                DispatchQueue.main.async {
                    self.countDown()
                }
            })
            timer?.start()
        }
    }
    
    var timer: Repeater?
    var seconds = 10.0
    var isTimerRunning = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupLayout () {
        let colors = Colors()
        let backgroundLayer = colors.gl
        backgroundLayer?.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)
        setupTimeLab()
    }
    
    func setupTimeLab() {
        let hours = floor(seconds / 3600)
        var mins = 0.0
        var displaySeconds = 0.0
        if (hours == 0) {
            mins = floor(seconds / 60)
            displaySeconds = floor(seconds - mins * 60)
            timeLab.text = timeFormater(time: mins) + " : " + timeFormater(time: displaySeconds)
        } else {
            mins = floor((seconds - hours * 3600) / 60)
            displaySeconds = floor((seconds - hours * 3600 - mins * 60))
            timeLab.text = timeFormater(time: hours) + " : " + timeFormater(time: mins) + " : " + timeFormater(time: displaySeconds)
        }
    }
    
    func timeFormater(time: Double) -> String {
        if (time < 10) {
            return "0" + String(Int(time))
        } else {
            return String(Int(time))
        }
    }
    
    func timerModifier(isAdd: Bool) {
        if (isAdd && seconds < 216000) {
            seconds += 1
        } else if (seconds > 1){
            seconds -= 1
        }
    }
    
    func countDown() {
        if (seconds != 0) {
            seconds -= 1
            setupTimeLab()
        } else {
            if let existingTimer = timer {
                existingTimer.pause()
                timer = nil
            }
        }
    }
}

class Colors {
    var gl:CAGradientLayer!
    
    init() {
        let colorBottom = UIColor(named: "orange300")!
        let colorTop = UIColor(named: "orange100")!
        
        self.gl = CAGradientLayer()
        self.gl.colors = [colorTop.cgColor, colorBottom.cgColor]
        self.gl.locations = [0.0, 1.0]
    }
}
