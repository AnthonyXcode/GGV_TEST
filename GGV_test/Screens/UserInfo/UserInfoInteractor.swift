//
//  UserInfoInteractor.swift
//  GGV_test
//
//  Created by Chan Yun Yuen on 7/10/2018.
//  Copyright © 2018 GGV. All rights reserved.
//

import RIBs
import RxSwift

protocol UserInfoRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol UserInfoPresentable: Presentable {
    var listener: UserInfoPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol UserInfoListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class UserInfoInteractor: PresentableInteractor<UserInfoPresentable>, UserInfoInteractable, UserInfoPresentableListener {

    weak var router: UserInfoRouting?
    weak var listener: UserInfoListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: UserInfoPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
