import UIKit

extension UILabel {
    struct ViewModel {
        let text: String
        let color: UIColor
        let font: UIFont
        let alignment: NSTextAlignment
        
        init(text: String = "",
             font: UIFont = .body,
             color: UIColor = .text,
             // rtl support on
             alignment: NSTextAlignment = .natural) {
            self.text = text
            self.color = color
            self.font = font
            self.alignment = alignment
        }
    }

    convenience init(frame: CGRect, model: ViewModel) {
        self.init(frame: frame)
        text = model.text
        textColor = model.color
        font = model.font
        textAlignment = model.alignment
    }
}
