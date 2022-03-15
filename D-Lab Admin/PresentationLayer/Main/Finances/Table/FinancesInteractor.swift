import Foundation

protocol IPaymentsInteractor {
    var payments: [Payment] { get }
    
    func fetch()
}

enum PaymentsState {
    case doctors, clinics
}

class PaymentsInteractor: IPaymentsInteractor {
    
    let presenter: IPaymentsPresenter
    let PaymentsService: IPaymentsService
    
    private(set) var payments: [Payment] = []
    
    init(presenter: IPaymentsPresenter, PaymentsService: PaymentsService) {
        self.presenter = presenter
        self.PaymentsService = PaymentsService
    }
    
    func fetch() {
        PaymentsService.get { [weak self] result in
            switch result {
            case .success(let payments):
                self?.payments = payments
                self?.presenter.updateState()
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}
