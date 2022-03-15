//
//  DependencyContainer.swift
//  D-Lab Admin
//
//  Created by Egor Fedyaev on 13.03.2022.
//

import Foundation

class ServiceLocator {
    private let pathFactory = PathFactory(base: "http://94.250.251.166:8000")
    private let sessionManager = URLSessionManager()
    private let userDefaultsManager = UserDefaultsManager()
    
    lazy var authService = AuthService(base: pathFactory.baseURL,
                                       path: pathFactory.auth,
                                       userDefaults: userDefaultsManager,
                                       session: sessionManager)
    
    lazy var ordersService = OrdersService(base: pathFactory.baseURL,
                                           path: pathFactory.orders,
                                           userDefaults: userDefaultsManager,
                                           session: sessionManager)
    
    lazy var clientsService = ClientsService(base: pathFactory.baseURL,
                                            doctorsPath: pathFactory.doctors,
                                            clinicsPath: pathFactory.clinics,
                                            userDefaults: userDefaultsManager,
                                            session: sessionManager)
    
    lazy var paymentsService = PaymentsService(base: pathFactory.baseURL,
                                           path: pathFactory.payments,
                                           userDefaults: userDefaultsManager,
                                           session: sessionManager)
    
    var isSignedIn: Bool { return userDefaultsManager.getBool(for: .isSignedIn) }
    
    private let coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func buildLogin() -> LoginGraph {
        return LoginGraph(injector: self, authService: authService)
    }
    
    func buildOrders() -> OrdersGraph {
        return OrdersGraph(coordinator: coordinator, ordersService: ordersService)
    }
    
    func buildClients() -> ClientsGraph {
        return ClientsGraph(coordinator: coordinator, clientsService: clientsService)
    }
    
    func buildPayments() -> PaymentsGraph {
        return PaymentsGraph(coordinator: coordinator, PaymentsService: paymentsService)
    }
}
