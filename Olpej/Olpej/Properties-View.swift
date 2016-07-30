public enum LayoutEdge {
    case top
    case bottom
    case left
    case right

    public var hashValue: Int {
        switch(self) {
        case top: return 1
        case bottom: return 2
        case left: return 3
        case right: return 4
        }
    }
}

extension Property {
    public static func backgroundColor<T: UIView>(color: UIColor) -> Property<T> {
        return Property<T>("uiview.backgroundColor", color.hashValue) { mode, view in
            switch(mode) {
            case .remove: view.backgroundColor = nil
            case .update: view.backgroundColor = color
            }
        }
    }

    public static func hidden<T: UIView>(value: Bool) -> Property<T> {
        return Property<T>("uiview.button", value.hashValue) { mode, view in
            switch(mode) {
            case .remove: view.hidden = false
            case .update: view.hidden = value
            }
        }
    }

    public static func opaque<T: UIView>(value: Bool) -> Property<T> {
        return Property<T>("uiview.button", value.hashValue) { mode, view in
            switch(mode) {
            case .remove: view.opaque = false
            case .update: view.opaque = value
            }
        }
    }

    public static func alpha<T: UIView>(value: CGFloat) -> Property<T> {
        return Property<T>("uiview.isHidden", value.hashValue) { mode, view in
            switch(mode) {
            case .remove: view.alpha = CGFloat(1)
            case .update: view.alpha = value
            }
        }
    }

    public static func frame<T: UIView>(x x: Double, y: Double, width: Double, height: Double) -> Property<T> {
        let hashValue = x.hashValue &+ y.hashValue &+ width.hashValue &+ height.hashValue
        return Property<T>("uiview.frame", hashValue) { mode, view in
            switch(mode) {
            case .remove: view.frame = CGRect()
            case.update: view.frame = CGRect(x: x, y: y, width: width, height: height)
            }
        }
    }

    public static func centerX<T: UIView>() -> Property<T> {
        return Property<T>("view.centerX", 0) { mode, view in
            if let superview = view.superview {
                view.translatesAutoresizingMaskIntoConstraints = false
                let constraint = NSLayoutConstraint(item: view, attribute: .CenterX, relatedBy: .Equal, toItem: superview, attribute: .CenterX, multiplier: 1.0, constant: 0)
                superview.addConstraint(constraint)
            }

        }
    }

    public static func centerY<T: UIView>() -> Property<T> {
        return Property<T>("view.centerY", 0) { mode, view in
            if let superview = view.superview {
                view.translatesAutoresizingMaskIntoConstraints = false
                let constraint = NSLayoutConstraint(item: view, attribute: .CenterY, relatedBy: .Equal, toItem: superview, attribute: .CenterY, multiplier: 1.0, constant: 0)
                superview.addConstraint(constraint)
            }

        }
    }
}
