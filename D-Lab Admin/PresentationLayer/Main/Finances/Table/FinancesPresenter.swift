import Foundation

protocol IPaymentsPresenter {
    // execution required after init
    func set(view: PaymentsView)
    func updateState()
}

class PaymentsPresenter: IPaymentsPresenter {
    
    weak var view: PaymentsView?
    
    private let coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func set(view: PaymentsView) {
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
