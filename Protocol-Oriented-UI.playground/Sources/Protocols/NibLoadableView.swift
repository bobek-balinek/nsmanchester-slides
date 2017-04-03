import UIKit

public protocol NibLoadableView: class {}

public extension NibLoadableView where Self: UIView {

    static var nibName: String {
        return String(describing: self)
    }
}

extension UITableViewCell: NibLoadableView {}
extension UICollectionViewCell: NibLoadableView {}
