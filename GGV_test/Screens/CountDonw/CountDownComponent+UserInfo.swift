//
//  CountDownComponent+UserInfo.swift
//  GGV_test
//
//  Created by Chan Yun Yuen on 15/10/2018.
//  Copyright © 2018 GGV. All rights reserved.
//

import RIBs

/// The dependencies needed from the parent scope of CountDown to provide for the UserInfo scope.
// TODO: Update CountDownDependency protocol to inherit this protocol.
protocol CountDownDependencyUserInfo: Dependency {
    // TODO: Declare dependencies needed from the parent scope of CountDown to provide dependencies
    // for the UserInfo scope.
}

extension CountDownComponent: UserInfoDependency {

    // TODO: Implement properties to provide for UserInfo scope.
}
