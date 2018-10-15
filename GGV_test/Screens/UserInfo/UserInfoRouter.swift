//
//  UserInfoRouter.swift
//  GGV_test
//
//  Created by Chan Yun Yuen on 7/10/2018.
//  Copyright © 2018 GGV. All rights reserved.
//

import RIBs

protocol UserInfoInteractable: Interactable {
    var router: UserInfoRouting? { get set }
    var listener: UserInfoListener? { get set }
}

protocol UserInfoViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class UserInfoRouter: ViewableRouter<UserInfoInteractable, UserInfoViewControllable>, UserInfoRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: UserInfoInteractable, viewController: UserInfoViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
