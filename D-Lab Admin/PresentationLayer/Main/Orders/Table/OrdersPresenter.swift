import Foundation

protocol IOrdersPresenter {
    // execution required after init
    func set(view: OrdersView)
    func updateState()
}

class OrdersPresenter: IOrdersPresenter {
    
    weak var view: OrdersView?
    
    private let coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
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
}
