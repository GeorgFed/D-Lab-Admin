import UIKit

extension UIFont {
    // * fonts need to be added here before usage
    static var largeTitle: UIFont {
        UIFont.systemFont(ofSize: 28, weight: .bold)
    }

    static var title: UIFont {
        UIFont.systemFont(ofSize: 24, weight: .medium)
    }

    static var body: UIFont {
        UIFont.systemFont(ofSize: 14.0, weight: .regular)
    }

    static var button: UIFont {
        UIFont.systemFont(ofSize: 14.0, weight: .regular)
    }

    static var header1: UIFont {
        UIFont.systemFont(ofSize: 20.0, weight: .bold)
    }

    static var header2: UIFont {
        UIFont.systemFont(ofSize: 18.0, weight: .medium)
    }

    static var header3: UIFont {
        UIFont.systemFont(ofSize: 18.0, weight: .medium)
    }

    static var caption: UIFont {
        UIFont.systemFont(ofSize: 12.0, weight: .medium)
    }
}
