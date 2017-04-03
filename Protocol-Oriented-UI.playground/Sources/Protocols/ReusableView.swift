import UIKit

public protocol ReusableView: class {}

public extension ReusableView where Self: UIView {

    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView {}
extension UICollectionViewCell: ReusableView {}
