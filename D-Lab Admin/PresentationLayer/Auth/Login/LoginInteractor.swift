import UIKit

protocol ILoginInteractor {
    func updateSignInButtonState()
    func signIn(username: String, password: String)
    func signUp()
}

class LoginInteractor: ILoginInteractor {
    private let presenter: ILoginPresenter
    private let authService: IAuthService

    init(presenter: ILoginPresenter, authService: IAuthService) {
        self.presenter = presenter
        self.authService = authService
    }
    
    func updateSignInButtonState() {
        presenter.updateState()
    }
    
    func signIn(username: String, password: String) {
        authService.authorize(user: UserCreds(username: username, password: password)) { [weak self] result in
            switch result {
            case .success(()):
                self?.presenter.openMain()
                break
            case .failure(let error):
                self?.presenter.setError(error)
                break
            }
        }
    }
    
    func signUp() { }
}
