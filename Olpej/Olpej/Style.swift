import Foundation

public enum StyleSize: Int {
    case any
    case compact
    case regular
}

public enum StyleLayoutDirection: Int {
    case any
    case leftToRight
    case rightToLeft
}

public struct Style<V: UIView> {
    let horizontal: StyleSize
    let vertical: StyleSize
    let direction: StyleLayoutDirection
    let properties: [Property<V>]
    let description: String?

    init(horizontal: StyleSize = .any, vertical: StyleSize = .any, direction: StyleLayoutDirection = .any,  properties: [Property<V>], description: String? = nil) {
        self.horizontal = horizontal
        self.vertical = vertical
        self.direction = direction
        self.properties = properties
        self.description = description
    }
}

extension Style {
    func appliesTo(horizontal horizontal: UIUserInterfaceSizeClass, vertical: UIUserInterfaceSizeClass, direction: UIUserInterfaceLayoutDirection) -> Bool {
        return (self.horizontal == .any || self.horizontal.rawValue == horizontal.rawValue) &&
               (self.vertical == .any || self.vertical.rawValue == vertical.rawValue) &&
               (self.direction == .any || self.direction.rawValue == direction.rawValue)
    }
}

extension Style: Hashable {
    public var hashValue: Int {
        return properties.reduce(0) {$0 + $1.hashValue} + horizontal.hashValue + vertical.hashValue + direction.hashValue
    }
}

public func == <A, B>(lhs: Style<A>, rhs: Style<B>) -> Bool {
    return false
}

public func == <A>(lhs: Style<A>, rhs: Style<A>) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
