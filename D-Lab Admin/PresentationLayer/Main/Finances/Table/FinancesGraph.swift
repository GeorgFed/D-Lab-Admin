import UIKit

class PaymentsGraph {
    private let view: PaymentsView
    private let interactor: IPaymentsInteractor
    private let presenter: IPaymentsPresenter
    private let coordinator: Coordinator
    
    var viewController: UIViewController { view }
    
    init(coordinator: Coordinator, PaymentsService: PaymentsService) {
        self.coordinator = coordinator
        presenter = PaymentsPresenter(coordinator: coordinator)
        interactor = PaymentsInteractor(presenter: presenter, PaymentsService: PaymentsService)
        view = PaymentsView(interactor: interactor)
        presenter.set(view: view)
    }
}
