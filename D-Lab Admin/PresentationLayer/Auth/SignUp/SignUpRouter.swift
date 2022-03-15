import Foundation

protocol ISignUpRouter {
    // execution required after init
    func set(view: SignUpView)
}

class SignUpRouter: ISignUpRouter {
    weak var view: SignUpView?
    
    func set(view: SignUpView) {
        self.view = view
    }
}
