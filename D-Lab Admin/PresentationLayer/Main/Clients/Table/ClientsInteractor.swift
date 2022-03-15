import Foundation

protocol IClientsInteractor {
    var doctors: [Doctor] { get }
    var clinics: [Clinic] { get }
    var state: ClientsState { get }
    
    func clientStateChanged(value: Int)
    func fetch()
}

enum ClientsState {
    case doctors, clinics
}

class ClientsInteractor: IClientsInteractor {
    
    let presenter: IClientsPresenter
    let ClientsService: IClientsService
    
    private(set) var doctors: [Doctor] = []
    private(set) var clinics: [Clinic] = []
    private(set) var state: ClientsState = .doctors
    
    init(presenter: IClientsPresenter, ClientsService: ClientsService) {
        self.presenter = presenter
        self.ClientsService = ClientsService
    }
    
    func fetch() {
        fetchDoctors()
        fetchClinics()
    }
    
    func fetchDoctors() {
        ClientsService.getDoctors { [weak self] result in
            switch result {
            case .success(let doctors):
                self?.doctors = doctors
                self?.presenter.updateState()
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func fetchClinics() {
        ClientsService.getClinics { [weak self] result in
            switch result {
            case .success(let clinics):
                self?.clinics = clinics
                self?.presenter.updateState()
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func clientStateChanged(value: Int) {
        state = value == 0 ? .doctors : .clinics
        presenter.updateState()
    }
}
