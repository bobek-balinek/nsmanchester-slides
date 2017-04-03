import Foundation

public protocol Configurable: class {
    func configured(with model: ViewModel) -> Self
}
