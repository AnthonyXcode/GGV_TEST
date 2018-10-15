//
//  UserInfoBuilder.swift
//  GGV_test
//
//  Created by Chan Yun Yuen on 7/10/2018.
//  Copyright © 2018 GGV. All rights reserved.
//

import RIBs

protocol UserInfoDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class UserInfoComponent: Component<UserInfoDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol UserInfoBuildable: Buildable {
    func build(withListener listener: UserInfoListener) -> UserInfoRouting
}

final class UserInfoBuilder: Builder<UserInfoDependency>, UserInfoBuildable {

    override init(dependency: UserInfoDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: UserInfoListener) -> UserInfoRouting {
        let component = UserInfoComponent(dependency: dependency)
        let viewController = UserInfoViewController()
        let interactor = UserInfoInteractor(presenter: viewController)
        interactor.listener = listener
        return UserInfoRouter(interactor: interactor, viewController: viewController)
    }
}
