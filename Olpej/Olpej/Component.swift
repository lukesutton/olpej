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
    func render(to targetView: UIView?) -> UIView
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
    public func render(to targetView: UIView? = nil) -> UIView {
        let view = View()
        targetView?.op_addSubview(view)
        for attr in attributes {
            attr.update(.update, view)
        }
        for child in children {
            child.render(to: view)
        }
        return view
    }
}

public func view(identifier: ComponentIdentifier<UIView>, _ attributes: Property<UIView>...) -> Component<UIView> {
    return Component(identifier: identifier, attributes: attributes)
}

public func button(identifier: ComponentIdentifier<UIButton>, _ attributes: Property<UIButton>...) -> Component<UIButton> {
    return Component(identifier: identifier, attributes: attributes)
}

public func stackView(identifier: ComponentIdentifier<UIStackView>, _ attributes: Property<UIStackView>...) -> Component<UIStackView> {
    return Component(identifier: identifier, attributes: attributes)
}

public func label(identifier: ComponentIdentifier<UILabel>, _ attributes: Property<UILabel>...) -> Component<UILabel> {
    return Component(identifier: identifier, attributes: attributes)
}

public func segmentedControl(identifier: ComponentIdentifier<UISegmentedControl>, _ attributes: Property<UISegmentedControl>...) -> Component<UISegmentedControl> {
    return Component(identifier: identifier, attributes: attributes)
}

public func textField(identifier: ComponentIdentifier<UITextField>, _ attributes: Property<UITextField>...) -> Component<UITextField> {
    return Component(identifier: identifier, attributes: attributes)
}

public func slider(identifier: ComponentIdentifier<UISlider>, _ attributes: Property<UISlider>...) -> Component<UISlider> {
    return Component(identifier: identifier, attributes: attributes)
}

public func switchControl(identifier: ComponentIdentifier<UISwitch>, _ attributes: Property<UISwitch>...) -> Component<UISwitch> {
    return Component(identifier: identifier, attributes: attributes)
}

public func activityIndicatorView(identifier: ComponentIdentifier<UIActivityIndicatorView>, _ attributes: Property<UIActivityIndicatorView>...) -> Component<UIActivityIndicatorView> {
    return Component(identifier: identifier, attributes: attributes)
}

public func progressView(identifier: ComponentIdentifier<UIProgressView>, _ attributes: Property<UIProgressView>...) -> Component<UIProgressView> {
    return Component(identifier: identifier, attributes: attributes)
}

public func pageControl(identifier: ComponentIdentifier<UIPageControl>, _ attributes: Property<UIPageControl>...) -> Component<UIPageControl> {
    return Component(identifier: identifier, attributes: attributes)
}

public func stepper(identifier: ComponentIdentifier<UIStepper>, _ attributes: Property<UIStepper>...) -> Component<UIStepper> {
    return Component(identifier: identifier, attributes: attributes)
}

public func imageView(identifier: ComponentIdentifier<UIImageView>, _ attributes: Property<UIImageView>...) -> Component<UIImageView> {
    return Component(identifier: identifier, attributes: attributes)
}

public func textView(identifier: ComponentIdentifier<UITextView>, _ attributes: Property<UITextView>...) -> Component<UITextView> {
    return Component(identifier: identifier, attributes: attributes)
}

public func scrollView(identifier: ComponentIdentifier<UIScrollView>, _ attributes: Property<UIScrollView>...) -> Component<UIScrollView> {
    return Component(identifier: identifier, attributes: attributes)
}


