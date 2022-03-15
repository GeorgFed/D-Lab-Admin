import UIKit

extension UIColor {
    // * app colors must be added here before usage
    // * dark theme support is enabled
    // * references can be seen in assets
    // * 10:30:60 primary:secondary:background
    static var primary: UIColor { UIColor(named: "Primary")! }
    static var secondary: UIColor { UIColor(named: "Secondary")! }
    static var background: UIColor { UIColor(named: "Background")! }
    static var placeholder: UIColor { UIColor(named: "Placeholder")! }
    static var unselected: UIColor { UIColor(named: "Unselected")! }
    static var disabled: UIColor { UIColor(named: "Disabled")! }
    static var text: UIColor { UIColor(named: "Text")! }
}
