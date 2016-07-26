import Foundation

public struct ComponentIdentifier<V: UIView>: Hashable, Equatable {
    let identifier: String

    public static func identifier<V: UIView>(value: String) -> ComponentIdentifier<V> {
        return ComponentIdentifier<V>(value)
    }

    public init(_ identifier: String) {
        self.identifier = identifier
    }

    public var hashValue: Int {
        return identifier.hashValue
    }
}

public func ==<A, B>(lhs: ComponentIdentifier<A>, rhs: ComponentIdentifier<B>) -> Bool {
    return false
}

public func ==<A>(lhs: ComponentIdentifier<A>, rhs: ComponentIdentifier<A>) -> Bool {
    return lhs.identifier == rhs.identifier
}

public protocol ComponentType {
    func render() -> UIView
    var hashValue: Int { get }
}

public struct Component<View: UIView>: ComponentType, Equatable {
    public let identifier: ComponentIdentifier<View>
    public let attributes: Set<Property<View>>
    public let children: [ComponentType]

    public init(identifier: ComponentIdentifier<View>, attributes: [Property<View>], children: [ComponentType] = []) {
        self.init(identifier: identifier, attributes: Set(attributes), children: children)
    }

    public init(identifier: ComponentIdentifier<View>, attributes: Set<Property<View>>, children: [ComponentType] = []) {
        self.identifier = identifier
        self.attributes = attributes
        self.children = children
    }
    
    public func append(children: [ComponentType]) -> Component<View> {
        return Component<View>(identifier: self.identifier, attributes: self.attributes, children: self.children + children)
    }
    
    public var hashValue: Int {
        return attributes.reduce(0) {$0 &+ $1.hashValue} &+ children.reduce(0) {$0 &+ $1.hashValue}
    }
}

public func ==<A, B>(lhs: Component<A>, rhs: Component<B>) -> Bool {
    return false
}

public func ==<A>(lhs: Component<A>, rhs: Component<A>) -> Bool {
    return lhs.hashValue == rhs.hashValue
}

extension Component {
    public func render() -> UIView {
        let view = View()
        for attr in attributes {
            attr.update(.update, view)
        }
        for component in children {
            view.op_addSubview(component.render())
        }
        return view
    }
}

public func view(identifier: ComponentIdentifier<UIView>, _ attributes: Property<UIView>...) -> Component<UIView> {
    return Component<UIView>(identifier: identifier, attributes: attributes)
}

public func button(identifier: ComponentIdentifier<UIButton>, _ attributes: Property<UIButton>...) -> Component<UIButton> {
    return Component<UIButton>(identifier: identifier, attributes: attributes)
}

public func stackView(identifier: ComponentIdentifier<UIStackView>, _ attributes: Property<UIStackView>...) -> Component<UIStackView> {
    return Component<UIStackView>(identifier: identifier, attributes: attributes)
}


