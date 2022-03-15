import Foundation

protocol IOrdersInteractor {
    var orders: [Order] { get }
    
    func fetch()
}

class OrdersInteractor: IOrdersInteractor {
    let presenter: IOrdersPresenter
    let ordersService: IOrdersService
    
    private(set) var orders: [Order] = []
    
    init(presenter: IOrdersPresenter, ordersService: OrdersService) {
        self.presenter = presenter
        self.ordersService = ordersService
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
}
