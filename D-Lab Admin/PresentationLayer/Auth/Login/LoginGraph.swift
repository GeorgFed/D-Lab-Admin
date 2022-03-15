import UIKit

class LoginGraph {
    private let view: LoginView
    private let interactor: ILoginInteractor
    private let presenter: ILoginPresenter
    private let coordinator: Coordinator
    
    var viewController: UIViewController { view }
    
    init(coordinator: Coordinator, authService: IAuthService) {
        self.coordinator = coordinator
        presenter = LoginPresenter(coordinator: coordinator)
        interactor = LoginInteractor(presenter: presenter,
                                     authService: authService)
        view = LoginView(interactor: interactor)
        presenter.set(view: view)
    }
}
