//
//  TextField.swift
//  D-Lab Admin
//
//  Created by Egor Fedyaev on 13.03.2022.
//

import UIKit

class DLTextField: UITextField {
    struct ViewModel {
        let placeholderText: String
        let placeholderColor: UIColor
        let backgroundColor: UIColor
        let selectedBorderColor: UIColor
        let unselectedBorderColor: UIColor
        let borderWidth: CGFloat
        let font: UIFont
        let cornerRadius: CGFloat
        
        init(placeholderText: String,
             placeholderColor: UIColor = .systemGray2,
             backgroundColor: UIColor = .systemBackground,
             selectedBorderColor: UIColor = .text,
             unselectedBorderColor: UIColor = .unselected,
             borderWidth: CGFloat = 1.0,
             font: UIFont = UIFont.systemFont(ofSize: 14.0),
             cornerRadius: CGFloat = 10.0) {
            self.placeholderText = placeholderText
            self.placeholderColor = placeholderColor
            self.backgroundColor = backgroundColor
            self.selectedBorderColor = selectedBorderColor
            self.unselectedBorderColor = unselectedBorderColor
            self.borderWidth = borderWidth
            self.font = font
            self.cornerRadius = cornerRadius
        }
    }
    
    private var model: ViewModel?
    // for now there is no need to inject it
    private let padding = UIEdgeInsets(top: 0, left: 16.0, bottom: 0, right: 16.0)
    
    init(model: ViewModel, frame: CGRect) {
        super.init(frame: frame)
        update(with: model)
    }
    
    public func update(with model: ViewModel) {
        self.model = model
        layer.borderWidth = model.borderWidth
        layer.borderColor = model.unselectedBorderColor.cgColor
        layer.cornerRadius = model.cornerRadius
        layer.masksToBounds = true
        placeholder = model.placeholderText
        backgroundColor = model.backgroundColor
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "",
                                                   attributes: [NSAttributedString.Key.foregroundColor: model.placeholderColor,
                                                                NSAttributedString.Key.font: model.font])
    }
    
    public func setSelected(_ value: Bool) {
        guard let model = model else { return }
        layer.borderColor = value ? model.selectedBorderColor.cgColor : model.unselectedBorderColor.cgColor
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
