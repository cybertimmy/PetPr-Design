import UIKit

extension UIFont {
    static func boldFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Helvetica-Bold", size: size)!
    }
    static func lightFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Helvetica-Light", size: size)!
    }
}
