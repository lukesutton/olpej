import Foundation

enum Operation<V: UIView> {
    case removeView(ComponentIdentifier<V>)
    case moveView(ComponentIdentifier<V>, Int)
    case updateView(ComponentIdentifier<V>)
}
