import Foundation

protocol IClientsPresenter {
    // execution required after init
    func set(view: ClientsView)
    func updateState()
}

class ClientsPresenter: IClientsPresenter {
    
    weak var view: ClientsView?
    
    private let coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func set(view: ClientsView) {
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
