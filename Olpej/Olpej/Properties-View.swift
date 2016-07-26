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
}
