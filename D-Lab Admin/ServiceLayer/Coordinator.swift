//
//  Coordinator.swift
//  D-Lab Admin
//
//  Created by Egor Fedyaev on 14.03.2022.
//

import UIKit

enum Route: Int {
    case login
    case main
}



final class Coordinator {
    
    weak var injector: ServiceLocator?
    
    var route: Route?
    
    // required call
    func set(injector: ServiceLocator) {
        self.injector = injector
        route = injector.isSignedIn ? .main : .login
    }
    
    func createOrderScreen() -> UINavigationController {
        guard let injector = injector else {
            return UINavigationController()
        }
        let graph = injector.buildOrders()
        let viewController = graph.viewController
        viewController.tabBarItem.title = "Наряды"
        viewController.tabBarItem.image = UIImage(systemName: "folder")
        viewController.tabBarItem.selectedImage = UIImage(systemName: "folder.fill")
        return UINavigationController(rootViewController: viewController)
    }
    
    func createClientsScreen() -> UINavigationController {
        guard let injector = injector else {
            return UINavigationController()
        }
        let graph = injector.buildClients()
        let viewController = graph.viewController
        viewController.tabBarItem.title = "Клиенты"
        viewController.tabBarItem.image = UIImage(systemName: "person.2")
        viewController.tabBarItem.selectedImage = UIImage(systemName: "person.2.fill")
        return UINavigationController(rootViewController: viewController)
    }
    
    func createFinancesScreen() -> UINavigationController {
        guard let injector = injector else {
            return UINavigationController()
        }
        let graph = injector.buildPayments()
        let viewController = graph.viewController
        viewController.tabBarItem.title = "Финансы"
        viewController.tabBarItem.image = UIImage(systemName: "dollarsign.square")
        viewController.tabBarItem.selectedImage = UIImage(systemName: "dollarsign.square.fill")
        return UINavigationController(rootViewController: viewController)
    }
    
    func getCurrentViewController() -> UIViewController {
        return getViewController(for: route ?? .login)
    }
    
    func getViewController(for route: Route) -> UIViewController {
        guard let injector = injector else {
            return UIViewController()
        }
        
        switch route {
        case .login:
            let graph = injector.buildLogin()
            return UINavigationController(rootViewController: graph.viewController)
        case .main:
            return TabBar(viewControllers: [createOrderScreen(),
                                            createClientsScreen(),
                                            createFinancesScreen()])
        }
    }
}
