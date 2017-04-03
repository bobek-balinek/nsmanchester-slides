import UIKit

public protocol Resizable {
    func preferredSize(in rect: CGRect) -> CGSize
}
