import UIKit

class SignUpView: UIViewController {
    private let interactor: ISignUpInteractor
    
    init(interactor: ISignUpInteractor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
