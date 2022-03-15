import UIKit

class ClientsView: UIViewController {
    private let interactor: IClientsInteractor
    
    lazy var tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.backgroundColor = .secondary
    // tableView.separatorStyle = .none
    tableView.delegate = self
    tableView.dataSource = self
    tableView.rowHeight = UITableView.automaticDimension
    tableView.register(ClientsCell.self, forCellReuseIdentifier: "\(ClientsCell.self)")
    return tableView
}()
    
    init(interactor: IClientsInteractor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Клиенты"
        view.addSubview(tableView, anchors: [.leading(0), .top(0), .trailing(0), .bottom(0)])
        interactor.fetch()
        addSegmentedConrtol()
        
    }
    
    func addSegmentedConrtol() {
        let segment: UISegmentedControl = UISegmentedControl(items: ["Доктора", "Клиники"])
        segment.setWidth(160, forSegmentAt: 0)
        segment.setWidth(160, forSegmentAt: 1)
//        if #available(iOS 13.0, *) {
//            segment.selectedSegmentTintColor = .primary
//        } else {
//            segment.tintColor = .primary
//        }
        
        segment.selectedSegmentIndex = 0
        segment.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.body], for: .normal)
        self.navigationItem.titleView = segment
        segment.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        interactor.clientStateChanged(value: sender.selectedSegmentIndex)
    }
}

extension ClientsView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch interactor.state {
        case .doctors:
            return interactor.doctors.count
        case .clinics:
            return interactor.clinics.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(ClientsCell.self)") as? ClientsCell else {
            return UITableViewCell()
        }
        switch interactor.state {
        case .doctors:
            cell.setup(with: interactor.doctors[indexPath.row])
        case .clinics:
            cell.setup(with: interactor.clinics[indexPath.row])
        }
        return cell
    }
}
