import UIKit

class PaymentsView: UIViewController {
    private let interactor: IPaymentsInteractor
    
    lazy var tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.backgroundColor = .secondary
    // tableView.separatorStyle = .none
    tableView.delegate = self
    tableView.dataSource = self
    tableView.rowHeight = UITableView.automaticDimension
    tableView.register(PaymentsCell.self, forCellReuseIdentifier: "\(PaymentsCell.self)")
    return tableView
}()
    
    init(interactor: IPaymentsInteractor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Финансы"
        view.addSubview(tableView, anchors: [.leading(0), .top(0), .trailing(0), .bottom(0)])
        interactor.fetch()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PaymentsView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor.payments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(PaymentsCell.self)") as? PaymentsCell else {
            return UITableViewCell()
        }
        cell.setup(with: interactor.payments[indexPath.row])
        return cell
    }
}
