//
//  CountDownViewController.swift
//  GGV_test
//
//  Created by Chan Yun Yuen on 7/10/2018.
//  Copyright © 2018 GGV. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import SnapKit
import KDCircularProgress
import Repeat

protocol CountDownPresentableListener: class {
    func addIncrement(_ seconds: Double)
    func reduceIncrement(_ seconds: Double)
    func startOrPause()
    func gotoInfo()
    func infoClick()
}

final class CountDownViewController: UIViewController, CountDownPresentable, CountDownViewControllable {
    func dismiss(viewController: ViewControllable) {
        if presentedViewController === viewController.uiviewController {
            dismiss(animated: true, completion: nil)
        }
    }
    
    func pressent(viewController: ViewControllable) {
        present(viewController.uiviewController, animated: true, completion: nil)
    }
    
    weak var listener: CountDownPresentableListener?
    let helper = Helper()
    var timer: Repeater? = nil
    var seconds = 10.0
    var displaySeconds = 0.0
    var isTimerRunning = false
    
    
    lazy var infoBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "info"), for: .normal)
        btn.addTarget(self, action: #selector(gotoInfo), for: .touchUpInside)
        return btn
    }()
    
    lazy var taskTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Task Here..."
        return textField
    }()
    
    lazy var countDownView: UIView = {
        let uiView = UIView()
        return uiView
    }()
    
    lazy var timeLab: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var upBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "up"), for: UIControlState.normal)
        btn.addTarget(self, action: #selector(addMin), for: .touchUpInside)
        return btn
    }()
    
    let downBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "down"), for: UIControlState.normal)
        btn.addTarget(self, action: #selector(reduceMin), for: .touchUpInside)
        return btn
    }()
    
    let progress: KDCircularProgress = {
        let progress = KDCircularProgress(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        progress.startAngle = -90
        progress.trackColor = UIColor.white
        progress.progressThickness = 0.1
        progress.trackThickness = 0.05
        progress.clockwise = true
        progress.glowMode = .forward
        progress.glowAmount = 0.9
        progress.progressColors = [UIColor.white, UIColor.white]
        progress.isUserInteractionEnabled = false
        return progress
    }()
    
    let playBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "play"), for: UIControlState.normal)
        btn.addTarget(self, action: #selector(start), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        addConstraint()
    }
    
    func initView() {
        view.addSubview(infoBtn)
        view.addSubview(taskTextField)
        countDownView.addSubview(upBtn)
        countDownView.addSubview(downBtn)
        countDownView.addSubview(timeLab)
        countDownView.addSubview(progress)
        view.addSubview(countDownView)
        view.addSubview(playBtn)
        let backgroundLayer = helper.getBackgroundLayer()
        backgroundLayer.frame = view.frame
        view.layer.insertSublayer(backgroundLayer, at: 0)
        helper.setupTimeLab(countSecond: 10.0, lable: timeLab)
    }
    
    func addConstraint() {
        infoBtn.snp.makeConstraints { (make) in
            make.topMargin.equalTo(20)
            make.leftMargin.equalTo(20)
        }
        
        taskTextField.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.topMargin.equalTo(100)
        }
        
        countDownView.snp.makeConstraints { (make) in
            make.center.equalTo(view)
            make.height.equalTo(300)
            make.width.equalTo(300)
        }
        
        upBtn.snp.makeConstraints { (make) in
            make.topMargin.equalTo(50)
            make.centerX.equalTo(countDownView)
        }
        
        downBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(-50)
            make.centerX.equalTo(countDownView)
        }
        
        timeLab.snp.makeConstraints { (make) in
            make.center.equalTo(countDownView)
        }
        
        playBtn.snp.makeConstraints { (make) in
            make.topMargin.equalTo(countDownView.snp.bottom).offset(50)
            make.centerX.equalTo(view)
        }
    }
    
    @objc func addMin(sender: UIButton) {
        listener?.addIncrement(seconds)
    }
    
    @objc func reduceMin(sender: UIButton) {
        listener?.reduceIncrement(seconds)
    }
    
    @objc func start(sender: UIButton) {
        if (timer != nil) {
            endTimerHandler()
        } else {
            startTimerHandler()
        }
        listener?.startOrPause()
    }
    
    @objc func gotoInfo(sender: UIButton) {
        listener?.gotoInfo()
    }
    
    func startTimerHandler() {
        upBtn.isHidden = true
        downBtn.isHidden = true
        playBtn.setImage(UIImage(named: "close"), for: UIControlState.normal)
        displaySeconds = 0
        timer = Repeater(interval: .seconds(1), observer: {_ in
            DispatchQueue.main.async {
                self.countDown()
            }
        })
        timer?.start()
        progress.animate(fromAngle: 0, toAngle: 360, duration: seconds, completion: {isComplete in
            print(isComplete)
        })
    }
    
    func endTimerHandler() {
        timer?.pause()
        timer = nil
        upBtn.isHidden = false
        downBtn.isHidden = false
        playBtn.setImage(UIImage(named: "play"), for: UIControlState.normal)
        helper.setupTimeLab(countSecond: seconds, lable: timeLab)
        if (progress.isAnimating()){
            progress.pauseAnimation()
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
    
    func updateIncrement(_ updatedTime: Double) {
        self.seconds = updatedTime
        helper.setupTimeLab(countSecond: updatedTime, lable: timeLab)
    }
}
