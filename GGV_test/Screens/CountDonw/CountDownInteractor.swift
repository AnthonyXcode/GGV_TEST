//
//  CountDownInteractor.swift
//  GGV_test
//
//  Created by Chan Yun Yuen on 7/10/2018.
//  Copyright © 2018 GGV. All rights reserved.
//

import RIBs
import RxSwift

protocol CountDownRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    func toInfoPage()
}

protocol CountDownPresentable: Presentable {
    var listener: CountDownPresentableListener? { get set }
    func updateIncrement(_ updatedTime: Double)
}

protocol CountDownListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func routeToInfo()
}

final class CountDownInteractor: PresentableInteractor<CountDownPresentable>, CountDownInteractable, CountDownPresentableListener {
    weak var router: CountDownRouting?
    weak var listener: CountDownListener?
    
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: CountDownPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        print("didBecomeActive")
        // TODO: Implement business logic here.
    }
    
    override func willResignActive() {
        super.willResignActive()
        print("willResignActive")
        // TODO: Pause any business logic.
    }
    
    func timerModifier(seconds: Double, isAdd: Bool) -> Double {        
        if (isAdd && seconds < 216000) {
            return seconds + 1
        } else if (seconds > 1){
            return seconds - 1
        } else {
            return seconds
        }
    }
    
    func infoClick() {
        router?.toInfoPage()
    }
    
    func startOrPause() {
        print("start")
    }
    
    func addIncrement(_ seconds: Double) {
        let time = timerModifier(seconds: seconds, isAdd: true)
        presenter.updateIncrement(time)
    }
    
    func reduceIncrement(_ seconds: Double) {
        let time = timerModifier(seconds: seconds, isAdd: false)
        presenter.updateIncrement(time)
    }
    
    func gotoInfo() {
        print("gotoInfo")
        router?.toInfoPage()
    }
}
