import UIKit

class OrdersView: UIViewController {
    private let interactor: IOrdersInteractor
    
    lazy var tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.backgroundColor = .secondary
    tableView.separatorStyle = .none
    tableView.delegate = self
    tableView.dataSource = self
    tableView.rowHeight = UITableView.automaticDimension
    tableView.register(OrdersCell.self, forCellReuseIdentifier: "\(OrdersCell.self)")
    return tableView
}()
    
    init(interactor: IOrdersInteractor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Наряды"
        view.addSubview(tableView, anchors: [.leading(0), .top(0), .trailing(0), .bottom(0)])
        interactor.fetch()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OrdersView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return interactor.orders.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(OrdersCell.self)") as? OrdersCell else {
            return UITableViewCell()
        }
        cell.setup(with: interactor.orders[indexPath.section])
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 96.0
//    }
}
