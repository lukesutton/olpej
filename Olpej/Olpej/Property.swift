import Foundation

public protocol PropertyType: Hashable {
    var hashValue: Int { get }
}

public enum PropertyAction {
    case remove
    case update
}

public struct Property<View: UIView>: PropertyType, Equatable, Hashable {
    public let tag: String
    public let hashValue: Int
    public let update: (ComponentIdentifier<View>, PropertyAction, View) -> Void
    
    public init(_ tag: String, _ hashValue: Int, update: (ComponentIdentifier<View>, PropertyAction, View) -> Void) {
        self.tag = tag
        self.hashValue = hashValue
        self.update = update
    }
}

public func ==<A, B>(lhs: Property<A>, rhs: Property<B>) -> Bool {
    return false
}

public func ==<A>(lhs: Property<A>, rhs: Property<A>) -> Bool {
    return lhs.tag == rhs.tag && lhs.hashValue == rhs.hashValue
}
