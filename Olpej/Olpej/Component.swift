import Foundation

public struct ComponentIdentifier<V: UIView>: Hashable, Equatable {
    let identifier: String

    public static func id<V: UIView>(value: String) -> ComponentIdentifier<V> {
        return ComponentIdentifier<V>(value)
    }

    public init(_ identifier: String) {
        self.identifier = identifier
    }

    public var hashValue: Int {
        return String(V).hashValue + identifier.hashValue
    }
}

public func ==<A, B>(lhs: ComponentIdentifier<A>, rhs: ComponentIdentifier<B>) -> Bool {
    return false
}

public func ==<A>(lhs: ComponentIdentifier<A>, rhs: ComponentIdentifier<A>) -> Bool {
    return lhs.identifier == rhs.identifier
}

public protocol ComponentType {
    func render(to targetView: UIView?) -> UIView
    var hashValue: Int { get }
}

public struct Component<View: UIView>: ComponentType, Equatable {
    public let identifier: ComponentIdentifier<View>
    public let styles: [Style<View>]
    public let directProperties: Set<Property<View>>
    public let properties: Set<Property<View>>
    public let children: [ComponentType]

    public init(id: ComponentIdentifier<View>, styles: [Style<View>] = [], properties: [Property<View>] = [], children: [ComponentType] = []) {
        self.identifier = id
        self.styles = styles
        self.directProperties = Set(properties)
        self.properties = Set(styles.flatMap {$0.properties} + properties)
        self.children = children
    }

    public init(id: String, styles: [Style<View>] = [], properties: [Property<View>] = [], children: [ComponentType] = []) {
        self.init(id: .id(id), styles: styles, properties: properties, children: children)
    }
    
    public var hashValue: Int {
        return properties.reduce(0) {$0 &+ $1.hashValue} &+ children.reduce(0) {$0 &+ $1.hashValue}
    }
}

public func ==<A, B>(lhs: Component<A>, rhs: Component<B>) -> Bool {
    return false
}

public func ==<A>(lhs: Component<A>, rhs: Component<A>) -> Bool {
    return lhs.hashValue == rhs.hashValue
}

extension Component {
    public func render(to targetView: UIView? = nil) -> UIView {
        let view = View()
        targetView?.op_addSubview(view)
        for prop in properties {
            prop.update(identifier, .update, view)
        }
        for child in children {
            child.render(to: view)
        }
        return view
    }
}
