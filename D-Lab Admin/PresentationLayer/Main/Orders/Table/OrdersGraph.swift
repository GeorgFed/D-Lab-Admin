import UIKit

class OrdersGraph {
    private let view: OrdersView
    private let interactor: IOrdersInteractor
    private let presenter: IOrdersPresenter
    private let coordinator: Coordinator
    
    var viewController: UIViewController { view }
    
    init(coordinator: Coordinator, ordersService: OrdersService) {
        self.coordinator = coordinator
        presenter = OrdersPresenter(coordinator: coordinator)
        interactor = OrdersInteractor(presenter: presenter, ordersService: ordersService)
        view = OrdersView(interactor: interactor)
        presenter.set(view: view)
    }
}
