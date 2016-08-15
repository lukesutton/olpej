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
    func render(to targetView: UIView?, horizontal: UIUserInterfaceSizeClass, vertical: UIUserInterfaceSizeClass, direction: UIUserInterfaceLayoutDirection) -> UIView
}

public struct Component<View: UIView>: ComponentType {
    public let identifier: ComponentIdentifier<View>
    public let styles: [Style<View>]
    public let children: [ComponentType]

    public init(id: ComponentIdentifier<View>, styles: [Style<View>] = [], properties: [Property<View>] = [], children: [ComponentType] = []) {
        self.identifier = id
        self.children = children

        if !properties.isEmpty {
            self.styles = styles + [Style(properties: properties)]
        }
        else {
            self.styles = styles
        }
    }

    public init(id: String, styles: [Style<View>] = [], properties: [Property<View>] = [], children: [ComponentType] = []) {
        self.init(id: .id(id), styles: styles, properties: properties, children: children)
    }
}

private struct IntermediateComponent<View: UIView> {
    let identifier: ComponentIdentifier<View>
    let properties: Set<Property<View>>
}

extension Component {
    private func intermediateFor(horizontal horizontal: UIUserInterfaceSizeClass, vertical: UIUserInterfaceSizeClass, direction: UIUserInterfaceLayoutDirection) -> IntermediateComponent<View> {
        let applicableStyles = styles.filter {$0.appliesTo(horizontal: horizontal, vertical: vertical, direction: direction)}
        let properties = applicableStyles.flatMap {$0.properties}
        return IntermediateComponent(identifier: identifier, properties: Set(properties))
    }

    public func render(to targetView: UIView? = nil, horizontal: UIUserInterfaceSizeClass = .Unspecified, vertical: UIUserInterfaceSizeClass = .Unspecified, direction: UIUserInterfaceLayoutDirection = .LeftToRight) -> UIView {
        let view = View()
        targetView?.op_addSubview(view)
        let intermediate = intermediateFor(horizontal: horizontal, vertical: vertical, direction: direction)
        for prop in intermediate.properties {
            prop.update(identifier, .update, view)
        }
        for child in children {
            child.render(to: view, horizontal: horizontal, vertical: vertical, direction: direction)
        }
        return view
    }
}
