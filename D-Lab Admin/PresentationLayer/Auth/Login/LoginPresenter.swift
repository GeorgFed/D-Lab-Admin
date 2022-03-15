import Foundation

protocol ILoginPresenter {
    // execution required after init
    func set(view: LoginView)
    func openMain()
    func updateState()
    func setError(_ error: Error)
}

class LoginPresenter: ILoginPresenter {
    
    weak var view: LoginView?
    
    private let coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func set(view: LoginView) {
        self.view = view
    }
    
    func openMain() {
        guard let view = view else { return }
        view.show(coordinator.getViewController(for: .main), sender: view)
    }
    
    func updateState() {
        guard let view = view else { return }
        view.signInButton.isEnabled = view.loginField.hasText && view.passwordField.hasText
    }
    
    func setError(_ error: Error) {
        
    }
}
