//
//  ViewController.swift
//  GGV_test
//
//  Created by Chan Yun Yuen on 14/8/2018.
//  Copyright © 2018 GGV. All rights reserved.
//

import UIKit
import Repeat
import KDCircularProgress
import RealmSwift

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
          helper.setupTimeLab(countSecond: seconds, lable: timeLab)
        }
    }
    
    @IBAction func downPress(_ sender: Any) {
        if (timer == nil) {
          timerModifier(isAdd: false)
          helper.setupTimeLab(countSecond: seconds, lable: timeLab)
        }
    }
    
    @IBAction func startPress(_ sender: Any) {
        if (timer != nil) {
            endTimerHandler()
        } else {
            startTimerHandler()
        }
    }
    
    var timer: Repeater? = nil
    var seconds = 10.0
    var displaySeconds = 0.0
    var isTimerRunning = false
    var progress: KDCircularProgress?
    let helper = Helper()
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupLayout () {
        let backgroundLayer = helper.getBackgroundLayer()
        backgroundLayer.frame = view.frame
        bgView.layer.insertSublayer(backgroundLayer, at: 0)
        helper.setupTimeLab(countSecond: seconds, lable: timeLab)
        
        progress = KDCircularProgress(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        progress?.startAngle = -90
        progress?.trackColor = UIColor.white
        progress?.progressThickness = 0.1
        progress?.trackThickness = 0.05
        progress?.clockwise = true
        progress?.glowMode = .forward
        progress?.glowAmount = 0.9
        progress?.progressColors = [UIColor.white, UIColor.white]
        progress?.isUserInteractionEnabled = false
        progress!.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 2)
        bgView.addSubview(progress!)
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
        if (displaySeconds != seconds) {
            displaySeconds += 1
            helper.setupTimeLab(countSecond: (seconds - displaySeconds), lable: timeLab)
        } else {
            endTimerHandler()
        }
    }
    
    func startTimerHandler() {
        upBtn.isHidden = true
        downBtn.isHidden = true
        playBtn.setBackgroundImage(UIImage(named: "close"), for: UIControlState.normal)
        displaySeconds = 0
        timer = Repeater(interval: .seconds(1), observer: {_ in
            DispatchQueue.main.async {
                self.countDown()
            }
        })
        timer?.start()
        progress?.animate(fromAngle: 0, toAngle: 360, duration: seconds, completion: {isComplete in
            print(isComplete)
        })
        let allRecords = realm.objects(RecodDoc.self)
    }
    
    func endTimerHandler() {
        timer?.pause()
        timer = nil
        upBtn.isHidden = false
        downBtn.isHidden = false
        playBtn.setBackgroundImage(UIImage(named: "play"), for: UIControlState.normal)
        helper.setupTimeLab(countSecond: seconds, lable: timeLab)
        if (progress?.isAnimating())!{
            progress?.pauseAnimation()
        }
        saveRecord()
    }
    
    func saveRecord() {
        let record = RecodDoc()
        record.timeSpent = displaySeconds
        record.maxTime = seconds
        let taskName = taskTF.text
        if (taskName != "") {
            record.name = taskName!
        } else {
            record.name = "No Task Name"
        }
        try! realm.write {
            realm.add(record)
        }
    }
}
