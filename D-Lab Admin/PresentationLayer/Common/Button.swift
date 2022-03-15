//
//  Button.swift
//  D-Lab Admin
//
//  Created by Egor Fedyaev on 13.03.2022.
//

import UIKit

class DLButton: UIButton {
    struct ViewModel {
        let text: String
        let enabledColor: UIColor
        let disabledColor: UIColor
        let enabledTextColor: UIColor
        let disabledTextColor: UIColor
        let font: UIFont
        let cornerRadius: CGFloat
        
        init(text: String,
             enabledColor: UIColor  = .primary,
             disabledColor: UIColor = .disabled,
             enabledTextColor: UIColor = .background,
             disabledTextColor: UIColor = .label,
             font: UIFont = UIFont.systemFont(ofSize: 14.0),
             cornerRadius: CGFloat = 10.0) {
            self.text = text
            self.enabledColor = enabledColor
            self.disabledColor = disabledColor
            self.enabledTextColor = enabledTextColor
            self.disabledTextColor = disabledTextColor
            self.font = font
            self.cornerRadius = cornerRadius
        }
    }
    
    override public var isEnabled: Bool {
        didSet {
            super.isEnabled = isEnabled
            if self.isEnabled {
                backgroundColor = enabledColor
                setTitleColor(enabledTextColor, for: .normal)
            } else {
                backgroundColor = disabledColor
                setTitleColor(disabledTextColor, for: .normal)
            }
        }
    }
    
    private var enabledColor: UIColor!
    private var disabledColor: UIColor!
    private var enabledTextColor: UIColor!
    private var disabledTextColor: UIColor!
    
    init(model: ViewModel, frame: CGRect) {
        super.init(frame: frame)
        update(with: model)
        self.addTarget(self, action: #selector(onPress), for: .touchUpInside)
    }
    
    public func update(with model: ViewModel) {
        setTitle(model.text, for: .normal)
        titleLabel?.font = model.font
        layer.cornerRadius = model.cornerRadius
        backgroundColor = model.enabledColor
        enabledColor = model.enabledColor
        disabledColor = model.disabledColor
        enabledTextColor = model.enabledTextColor
        disabledTextColor = model.disabledTextColor
        setTitleColor(enabledTextColor, for: .normal)
    }

    @objc func onPress() {
        let animationClosure = { [weak self] in
            guard let self = self else {
                return
            }
            self.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
            self.alpha = 0.8
           }
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       options: .curveLinear,
                       animations: animationClosure) { _ in
            self.transform = CGAffineTransform.identity
            self.alpha = 1.0
        }
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
