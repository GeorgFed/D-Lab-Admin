import Foundation

protocol ISignUpInteractor {
    
}

class SignUpInteractor: ISignUpInteractor {
    let presenter: ISignUpPresenter
    let router: ISignUpRouter
    
    init(presenter: ISignUpPresenter, router: ISignUpRouter) {
        self.presenter = presenter
        self.router = router
    }
}
