import UIKit

class OrderDetailssView: UITableViewController {
    private let order: Order
    
    
    init(order: Order) {
        self.order = order
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Наряд #\(order.id)"
        tableView.backgroundColor = .background
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "\(UITableViewCell.self)")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.font = .caption
        cell.textLabel?.textColor = .primary
        
        cell.detailTextLabel?.font = .header2
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Дата создания"
            cell.detailTextLabel?.text = order.date
        case 1:
            cell.textLabel?.text = "Клиника"
            cell.detailTextLabel?.text = order.clinic?.clinicName ?? "-"
        case 2:
            cell.textLabel?.text = "Врач"
            cell.detailTextLabel?.text = order.doctor?.doctorName ?? "-"
        case 3:
            cell.textLabel?.text = "Пациент"
            cell.detailTextLabel?.text = order.patient
        default:
            cell.textLabel?.text = "Цена"
            cell.detailTextLabel?.text = "\(order.totalPrice) ₽"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56.0
    }
}
