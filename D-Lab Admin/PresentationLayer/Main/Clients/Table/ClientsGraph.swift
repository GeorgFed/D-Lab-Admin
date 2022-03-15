import UIKit

class ClientsGraph {
    private let view: ClientsView
    private let interactor: IClientsInteractor
    private let presenter: IClientsPresenter
    private let coordinator: Coordinator
    
    var viewController: UIViewController { view }
    
    init(coordinator: Coordinator, clientsService: ClientsService) {
        self.coordinator = coordinator
        presenter = ClientsPresenter(coordinator: coordinator)
        interactor = ClientsInteractor(presenter: presenter, ClientsService: clientsService)
        view = ClientsView(interactor: interactor)
        presenter.set(view: view)
    }
}
