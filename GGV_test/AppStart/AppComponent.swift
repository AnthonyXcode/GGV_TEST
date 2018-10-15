//
//  AppComponent.swift
//  GGV_test
//
//  Created by Chan Yun Yuen on 7/10/2018.
//  Copyright © 2018 GGV. All rights reserved.
//

import RIBs

class AppComponent: Component<EmptyDependency>, CountDownDependency {
    init() {
        super.init(dependency: EmptyComponent())
    }
}
