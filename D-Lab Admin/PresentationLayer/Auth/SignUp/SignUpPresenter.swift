import Foundation

protocol ISignUpPresenter {
    // execution required after init
    func set(view: SignUpView)
}

class SignUpPresenter: ISignUpPresenter {
    
    weak var view: SignUpView?
    
    func set(view: SignUpView) {
        self.view = view
    }
    
}
