import UIKit

class LoginGraph {
    private let view: LoginView
    private let interactor: ILoginInteractor
    private let presenter: ILoginPresenter
    
    var viewController: UIViewController { view }
    
    init(injector: ServiceLocator, authService: IAuthService) {
        presenter = LoginPresenter(injector: injector)
        interactor = LoginInteractor(presenter: presenter,
                                     authService: authService)
        view = LoginView(interactor: interactor)
        presenter.set(view: view)
    }
}
