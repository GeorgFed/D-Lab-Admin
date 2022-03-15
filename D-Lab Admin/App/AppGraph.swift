//
//  AppGraph.swift
//  D-Lab Admin
//
//  Created by Egor Fedyaev on 13.03.2022.
//

import UIKit

final class AppGraph {
    private let coordinator: Coordinator
    private let injector: ServiceLocator

    public var viewController: UIViewController {
        coordinator.getCurrentViewController()
    }

    init() {
        coordinator = Coordinator()
        injector = ServiceLocator(coordinator: coordinator)
        coordinator.set(injector: injector)
    }
}
