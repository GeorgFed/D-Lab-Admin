import Foundation

protocol IOrdersInteractor {
    var orders: [Order] { get }
    
    func fetch()
    func onExit()
}

class OrdersInteractor: IOrdersInteractor {
    let presenter: IOrdersPresenter
    let ordersService: IOrdersService
    let authService: IAuthService
    
    private(set) var orders: [Order] = []
    
    init(presenter: IOrdersPresenter, ordersService: OrdersService, authService: AuthService) {
        self.presenter = presenter
        self.ordersService = ordersService
        self.authService = authService
    }
    
    func fetch() {
        ordersService.get { [weak self] result in
            switch result {
            case .success(let orders):
                self?.orders = orders
                self?.presenter.updateState()
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func onExit() {
        authService.signOut()
        presenter.showLogin()
    }
}
