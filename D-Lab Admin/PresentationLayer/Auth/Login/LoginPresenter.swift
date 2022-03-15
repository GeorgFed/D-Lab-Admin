import UIKit

protocol ILoginPresenter {
    // execution required after init
    func set(view: LoginView)
    func openMain()
    func updateState()
    func setError(_ error: Error)
}

class LoginPresenter: ILoginPresenter {
    
    weak var view: LoginView?
    
    private let injector: ServiceLocator
    
    init(injector: ServiceLocator) {
        self.injector = injector
    }
    
    func set(view: LoginView) {
        self.view = view
    }
    
    func openMain() {
        let tabBar = TabBar(viewControllers: [createOrderScreen(), createClientsScreen(), createFinancesScreen()])
        view?.setNewRootController(viewController: tabBar)
    }
    
    func updateState() {
        guard let view = view else { return }
        view.signInButton.isEnabled = view.loginField.hasText && view.passwordField.hasText
    }
    
    func setError(_ error: Error) {
        let alert = UIAlertController(title: "Неверный логин или пароль", message: "Пожалуйста, попробуйте снова", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .cancel))
        view?.present(alert, animated: true, completion: nil)
    }
    
    func createOrderScreen() -> UINavigationController {
        let graph = injector.buildOrders()
        let viewController = graph.viewController
        viewController.tabBarItem.title = "Наряды"
        viewController.tabBarItem.image = UIImage(systemName: "folder")
        viewController.tabBarItem.selectedImage = UIImage(systemName: "folder.fill")
        return UINavigationController(rootViewController: viewController)
    }
    
    func createClientsScreen() -> UINavigationController {
        let graph = injector.buildClients()
        let viewController = graph.viewController
        viewController.tabBarItem.title = "Клиенты"
        viewController.tabBarItem.image = UIImage(systemName: "person.2")
        viewController.tabBarItem.selectedImage = UIImage(systemName: "person.2.fill")
        return UINavigationController(rootViewController: viewController)
    }
    
    func createFinancesScreen() -> UINavigationController {
        let graph = injector.buildPayments()
        let viewController = graph.viewController
        viewController.tabBarItem.title = "Финансы"
        viewController.tabBarItem.image = UIImage(systemName: "dollarsign.square")
        viewController.tabBarItem.selectedImage = UIImage(systemName: "dollarsign.square.fill")
        return UINavigationController(rootViewController: viewController)
    }
}
