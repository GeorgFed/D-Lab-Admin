import UIKit

protocol IOrdersPresenter {
    // execution required after init
    func set(view: OrdersView)
    func updateState()
    func showLogin()
    func showExitAlert(completion: @escaping (_ showExit: Bool) -> Void)
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
    
    func showExitAlert(completion: @escaping (_ showExit: Bool) -> Void) {
        let alert = UIAlertController(title: "Вы уверены, что хотите выйти?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Да", style: .destructive, handler: { _ in completion(true) }))
        alert.addAction(UIAlertAction(title: "Нет", style: .cancel))
        view?.present(alert, animated: true, completion: nil)
    }
}
