//
//  Helper.swift
//  GGV_test
//
//  Created by Chan Yun Yuen on 15/8/2018.
//  Copyright © 2018 GGV. All rights reserved.
//

import UIKit
import Foundation

class Helper {
    func getBackgroundLayer() -> CAGradientLayer{
        let colorBottom = UIColor(named: "orange300")!
        let colorTop = UIColor(named: "orange100")!
        let backgroundLayer:CAGradientLayer = CAGradientLayer()
        backgroundLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
        backgroundLayer.locations = [0.0, 1.0]
        return backgroundLayer
    }
    
    func timeFormater(time: Double) -> String {
        if (time < 10) {
            return "0" + String(Int(time))
        } else {
            return String(Int(time))
        }
    }
    
    func setupTimeLab(countSecond: Double, lable: UILabel) {
        let hours = floor(countSecond / 3600)
        var mins = 0.0
        var displaySeconds = 0.0
        if (hours == 0) {
            mins = floor(countSecond / 60)
            displaySeconds = floor(countSecond - mins * 60)
            lable.text = timeFormater(time: mins) + " : " + timeFormater(time: displaySeconds)
        } else {
            mins = floor((countSecond - hours * 3600) / 60)
            displaySeconds = floor((countSecond - hours * 3600 - mins * 60))
            lable.text = timeFormater(time: hours) + " : " + timeFormater(time: mins) + " : " + timeFormater(time: displaySeconds)
        }
    }
}
