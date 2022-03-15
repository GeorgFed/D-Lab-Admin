import UIKit

class LoginView: UIViewController {
    private let interactor: ILoginInteractor
    
    lazy var loginField: DLTextField = {
        let model = DLTextField.ViewModel(placeholderText: LoginStrings.loginFieldPlaceholder)
        let field = DLTextField(model: model, frame: .zero)
        field.tag = 0
        field.spellCheckingType = .no
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.keyboardType = .emailAddress
        field.textContentType = .emailAddress
        field.activate(anchors: [.height(LoginValues.fieldHeight)])
        field.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return field
    }()
    
    lazy var passwordField: DLTextField = {
        let model = DLTextField.ViewModel(placeholderText: LoginStrings.passwordFieldPlacegolder)
        let field = DLTextField(model: model, frame: .zero)
        field.tag = 1
        field.spellCheckingType = .no
        field.spellCheckingType = .no
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.isSecureTextEntry = true
        field.textContentType = .password
        field.activate(anchors: [.height(LoginValues.fieldHeight)])
        field.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return field
    }()
    
    lazy var signInButton: DLButton = {
        let model = DLButton.ViewModel(text: LoginStrings.signInButtonText)
        let button = DLButton(model: model, frame: .zero)
        button.isEnabled = false
        button.activate(anchors: [.height(LoginValues.fieldHeight)])
        button.addTarget(self, action: #selector(signInPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var signUpButton: DLButton = {
        let model = DLButton.ViewModel(text: LoginStrings.signUpButtonText,
                                       enabledColor: .background,
                                       disabledColor: .background,
                                       enabledTextColor: .primary,
                                       disabledTextColor: .unselected)
        let button = DLButton(model: model, frame: .zero)
        button.activate(anchors: [.height(LoginValues.signUpHeight)])
        button.addTarget(self, action: #selector(signInPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var fieldStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [loginField, passwordField, signInButton])
        stack.axis = .vertical
        stack.spacing = LoginValues.stackSpace
        return stack
    }()
    
    init(interactor: ILoginInteractor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        loginField.delegate = self
        passwordField.delegate = self
        
        self.hideKeyboardWhenTappedAround()
        loginField.becomeFirstResponder()
        
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .background
        view.addSubview(fieldStack, anchors: [.centerY(LoginValues.centerYInset),
                                              .leading(LoginValues.ledingConstraint),
                                              .trailing(LoginValues.trailingConstraint)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let textField = textField as? DLTextField else { return }
        textField.setSelected(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let textField = textField as? DLTextField else { return }
        textField.setSelected(false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
         nextField.becomeFirstResponder()
      } else {
         textField.resignFirstResponder()
      }
      return false
    }
}

extension LoginView {
    
    @objc
    func textFieldDidChange(_ sender: UITextField) {
        interactor.updateSignInButtonState()
    }
    
    @objc
    func signInPressed(_ sender: UIButton) {
        guard let login = loginField.text, let password = passwordField.text else { return }
        interactor.signIn(username: login, password: password)
    }
    
    @objc
    func signUpPressed(_ sender: UIButton) {
        interactor.signUp()
    }
    
    func setNewRootController(viewController: UIViewController) {
        view.window?.rootViewController = viewController
    }
}
