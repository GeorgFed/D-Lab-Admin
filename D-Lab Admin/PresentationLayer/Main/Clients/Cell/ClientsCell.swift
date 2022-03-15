import UIKit

final class ClientsCell: UITableViewCell {
    
    private lazy var clientNameLabel: UILabel = {
        let label =  UILabel(frame: .zero, model: UILabel.ViewModel(font: .header2))
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel(frame: .zero, model: UILabel.ViewModel(font: .body, color: .unselected))
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var debtTitleLabel: UILabel = {
        return UILabel(frame: .zero, model: UILabel.ViewModel(text: "Долг", font: .caption, color: .unselected))
    }()
    
    private lazy var debtLabel: UILabel = {
        let label = UILabel(frame: .zero, model: UILabel.ViewModel(font: .body))
        return label
    }()
    
    private lazy var paidTitleLabel: UILabel = {
        return UILabel(frame: .zero, model: UILabel.ViewModel(text: "Оплачено", font: .caption, color: .unselected))
    }()
    
    private lazy var paidLabel: UILabel = {
        let label = UILabel(frame: .zero, model: UILabel.ViewModel(font: .body))
        return label
    }()
    
    private lazy var debtStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [debtTitleLabel, debtLabel])
        stack.axis = .horizontal
        stack.distribution = .fill
        return stack
    }()
    
    private lazy var paidStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [paidTitleLabel, paidLabel])
        stack.axis = .horizontal
        stack.distribution = .fill
        return stack
    }()
    
    private lazy var cardStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 4.0
        return stack
    }()
    
    func setup(with doctor: Doctor) {
        clientNameLabel.text = doctor.doctorName
        let contacts = doctor.contacts == "" ? "-" : doctor.contacts
        let comments = doctor.comment == "" ? "-" : doctor.comment
        infoLabel.text = "Контакты: \(contacts)\nКомментарии: \(comments)"
        cardStack.addArrangedSubview(clientNameLabel)
        cardStack.addArrangedSubview(infoLabel)
        
        selectionStyle = .none
        addSubview(cardStack, anchors: [.leading(16), .trailing(-16), .top(8), .bottom(-8)])
    }
    
    func setup(with clinic: Clinic) {
        
        clientNameLabel.text = clinic.clinicName
        let contacts = clinic.contacts == "" ? "-" : clinic.contacts
        let comments = clinic.comment == "" ? "-" : clinic.comment
        infoLabel.text = "Контакты: \(contacts)\nКомментарии: \(comments)"
        cardStack.addArrangedSubview(clientNameLabel)
        cardStack.addArrangedSubview(infoLabel)
        
        selectionStyle = .none
        addSubview(cardStack, anchors: [.leading(16), .trailing(-16), .top(8), .bottom(-8)])
    }
}
