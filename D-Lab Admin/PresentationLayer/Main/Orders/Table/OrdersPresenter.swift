import Foundation

protocol IOrdersPresenter {
    // execution required after init
    func set(view: OrdersView)
    func updateState()
    func showLogin()
}

class OrdersPresenter: IOrdersPresenter {
    
    weak var view: OrdersView?
    
    private let injector: ServiceLocator
    
    init(injector: ServiceLocator) {
        self.injector = injector
    }
    
    func set(view: OrdersView) {
        self.view = view
    }
    
    func updateState() {
        view?.tableView.reloadData()
    }
    
    func setError() {
        
    }
    
    func setLoading() {
        
    }
    
    func showLogin() {
        let graph = injector.buildLogin()
        view?.setNewRootController(viewController: graph.viewController)
    }
}
