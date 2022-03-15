import UIKit

class OrdersGraph {
    private let view: OrdersView
    private let interactor: IOrdersInteractor
    private let presenter: IOrdersPresenter
    
    var viewController: UIViewController { view }
    
    init(injector: ServiceLocator, ordersService: OrdersService, authService: AuthService) {
        presenter = OrdersPresenter(injector: injector)
        interactor = OrdersInteractor(presenter: presenter, ordersService: ordersService, authService: authService)
        view = OrdersView(interactor: interactor)
        presenter.set(view: view)
    }
}
