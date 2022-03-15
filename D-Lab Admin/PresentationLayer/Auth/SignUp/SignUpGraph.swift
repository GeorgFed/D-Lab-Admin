import UIKit

class SignUpGraph {
    private let view: SignUpView
    private let interactor: ISignUpInteractor
    private let presenter: ISignUpPresenter
    private let router: ISignUpRouter
    
    var viewController: UIViewController { view }
    
    init() {
        presenter = SignUpPresenter()
        router = SignUpRouter()
        interactor = SignUpInteractor(presenter: presenter, router: router)
        view = SignUpView(interactor: interactor)
        presenter.set(view: view)
        router.set(view: view)
    }
}
