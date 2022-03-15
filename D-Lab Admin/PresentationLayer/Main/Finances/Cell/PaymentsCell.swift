import UIKit

final class PaymentsCell: UITableViewCell {
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel(frame: .zero, model: UILabel.ViewModel(font: .caption, color: .unselected))
        return label
    }()
    
    private lazy var clientNameLabel: UILabel = {
        let label =  UILabel(frame: .zero, model: UILabel.ViewModel(font: .header2))
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel(frame: .zero, model: UILabel.ViewModel(font: .body))
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var debtTitleLabel: UILabel = {
        return UILabel(frame: .zero, model: UILabel.ViewModel(text: "Долг:", font: .body, color: .unselected))
    }()
    
    private lazy var debtLabel: UILabel = {
        let label = UILabel(frame: .zero, model: UILabel.ViewModel(font: .body, color: .primary))
        return label
    }()
    
    private lazy var paidTitleLabel: UILabel = {
        return UILabel(frame: .zero, model: UILabel.ViewModel(text: "Оплачено:", font: .body, color: .unselected))
    }()
    
    private lazy var paidLabel: UILabel = {
        let label = UILabel(frame: .zero, model: UILabel.ViewModel(font: .body, color: .primary))
        return label
    }()
    
    private lazy var debtStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [debtTitleLabel, debtLabel])
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 4.0
        return stack
    }()
    
    private lazy var paidStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [paidTitleLabel, paidLabel])
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 4.0
        return stack
    }()
    
    private lazy var cardStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 8.0
        return stack
    }()
    
    func setup(with payment: Payment) {
        clientNameLabel.text = payment.clinic.clinicName
        
        let contacts = payment.clinic.contacts == "" ? "-" : payment.clinic.contacts
        let comments = payment.clinic.comment == "" ? "-" : payment.clinic.comment
        
        dateLabel.text = payment.date
        infoLabel.text = "Контакты: \(contacts)\nКомментарии: \(comments)"
        
        cardStack.addArrangedSubview(dateLabel)
        cardStack.addArrangedSubview(clientNameLabel)
        cardStack.addArrangedSubview(infoLabel)
        cardStack.addArrangedSubview(paidStack)
        cardStack.addArrangedSubview(debtStack)
        let debt = payment.balance - payment.amount > 0 ? payment.balance - payment.amount : 0
        debtLabel.text = "\(debt) ₽"
        paidLabel.text = "\(payment.amount) ₽"
        selectionStyle = .none
        addSubview(cardStack, anchors: [.leading(16), .trailing(-16), .top(8), .bottom(-8)])
    }
}
