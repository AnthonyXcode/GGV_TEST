//
//  CountDownBuilder.swift
//  GGV_test
//
//  Created by Chan Yun Yuen on 7/10/2018.
//  Copyright © 2018 GGV. All rights reserved.
//

import RIBs

protocol CountDownDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class CountDownComponent: Component<CountDownDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol CountDownBuildable: Buildable {
    func build() -> LaunchRouting
}

final class CountDownBuilder: Builder<CountDownDependency>, CountDownBuildable {

    override init(dependency: CountDownDependency) {
        super.init(dependency: dependency)
    }

    func build() -> LaunchRouting {
        let component = CountDownComponent(dependency: dependency)
        let viewController = CountDownViewController()
        let interactor = CountDownInteractor(presenter: viewController)
        return CountDownRouter(interactor: interactor, viewController: viewController, component: component)
    }
}
