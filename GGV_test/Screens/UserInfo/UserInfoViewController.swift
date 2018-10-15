//
//  UserInfoViewController.swift
//  GGV_test
//
//  Created by Chan Yun Yuen on 7/10/2018.
//  Copyright © 2018 GGV. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import SnapKit

protocol UserInfoPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class UserInfoViewController: UIViewController, UserInfoPresentable, UserInfoViewControllable {

    weak var listener: UserInfoPresentableListener?
    let helper = Helper()
    
    let exitBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("dismiss", for: .normal)
        btn.tintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        btn.addTarget(self, action: #selector(onDismissClick), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        initLayout()
        initConstrain()
    }
    
    func initLayout() {
        let backgroundLayer = helper.getBackgroundLayer()
        backgroundLayer.frame = view.frame
        view.layer.insertSublayer(backgroundLayer, at: 0)
        
        view.addSubview(exitBtn)
    }
    
    func initConstrain() {
        exitBtn.snp.makeConstraints { (make) in
            make.center.equalTo(view)
        }
    }
    
    @objc func onDismissClick() {
        dismiss(animated: true, completion: nil)
    }
}
