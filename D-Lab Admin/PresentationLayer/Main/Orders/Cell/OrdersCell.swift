import UIKit

final class OrdersCell: UITableViewCell {
    
    private lazy var progressLabel: UILabel = {
        let label = UILabel(frame: .zero, model: UILabel.ViewModel(font: .caption, color: .primary))
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel(frame: .zero, model: UILabel.ViewModel(font: .caption, color: .unselected))
        return label
    }()
    
    private lazy var clientTitleLabel: UILabel = {
        let label = UILabel(frame: .zero, model: UILabel.ViewModel(text: "Клиент", font: .caption, color: .unselected))
        return label
    }()
    
    private lazy var clientLabel: UILabel = {
        let label =  UILabel(frame: .zero, model: UILabel.ViewModel(font: .header2))
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var clientStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [clientTitleLabel, clientLabel])
        stack.spacing = 2
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var patientTitleLabel: UILabel = {
        return UILabel(frame: .zero, model: UILabel.ViewModel(text: "Пациент", font: .caption, color: .unselected))
    }()
    
    private lazy var patientLabel: UILabel = {
        let label = UILabel(frame: .zero, model: UILabel.ViewModel(font: .header3))
        return label
    }()
    
    private lazy var patientStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [patientTitleLabel, patientLabel])
        stack.spacing = 2
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel(frame: .zero, model: UILabel.ViewModel(font: .body))
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel(frame: .zero, model: UILabel.ViewModel(font: .header2, color: .primary))
        return label
    }()
    
    private lazy var topStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [progressLabel, dateLabel])
        stack.axis = .horizontal
        stack.distribution = .fill
        return stack
    }()
    
    private lazy var cardStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 8.0
        return stack
    }()
    
    func setup(with order: Order) {
        progressLabel.text = order.progress
        dateLabel.text = order.date
        patientLabel.text = order.patient
        let status = order.isClosed ? "оплачен" : "не оплачен"
        let deadline = order.deadline ?? "не ограничен"
        infoLabel.text = "Срок выполнения: \(deadline)\nСтатус: \(status)"
        priceLabel.text = "\(order.totalPrice) ₽"
        
        cardStack.addArrangedSubview(topStack)
        
        if let clinic = order.clinic, let doctor = order.doctor {
            clientLabel.text = "\(clinic.clinicName), \(doctor.doctorName)"
            cardStack.addArrangedSubview(clientStack)
        }
        
        cardStack.addArrangedSubview(patientStack)
        cardStack.addArrangedSubview(infoLabel)
        cardStack.addArrangedSubview(priceLabel)
        
        selectionStyle = .none
        addSubview(cardStack, anchors: [.leading(16), .trailing(-16), .top(8), .bottom(-8)])
    }
}
