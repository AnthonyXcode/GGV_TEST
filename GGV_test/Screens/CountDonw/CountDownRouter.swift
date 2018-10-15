//
//  CountDownRouter.swift
//  GGV_test
//
//  Created by Chan Yun Yuen on 7/10/2018.
//  Copyright © 2018 GGV. All rights reserved.
//

import RIBs

protocol CountDownInteractable: Interactable, UserInfoListener {
    var router: CountDownRouting? { get set }
    var listener: CountDownListener? { get set }
}

protocol CountDownViewControllable: ViewControllable {
    func pressent(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class CountDownRouter: LaunchRouter<CountDownInteractable, CountDownViewControllable>, CountDownRouting {
    let component: CountDownComponent
    let infoBuilder: UserInfoBuilder
    var info: UserInfoRouting?
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: CountDownInteractable, viewController: CountDownViewControllable, component: CountDownComponent) {
        self.component = component
        infoBuilder = UserInfoBuilder(dependency: component)
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func toInfoPage() {
        let info = infoBuilder.build(withListener: interactor)
        self.info = info
        attachChild(info)
        viewController.pressent(viewController: info.viewControllable)
    }
}
