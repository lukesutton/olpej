extension Property {
    private static func findConstraint(name: String, inView view: UIView) -> NSLayoutConstraint? {
        guard let superview = view.superview else { return nil }
        for constraint in superview.constraints {
            if let id = constraint.identifier where id == name {
                return constraint
            }
        }
        return nil
    }

    private static func constraint<T: UIView>(name: String, builder: (T, UIView) -> NSLayoutConstraint) -> Property<T> {
        return Property<T>("view.\(name)", 0) { id, mode, view in
            switch(mode) {
            case .remove:
                findConstraint(name, inView: view)?.active = false
            case .update:
                if let constraint = findConstraint(name, inView: view) {
                    constraint.active = true
                }
                else if let superview = view.superview {
                    view.translatesAutoresizingMaskIntoConstraints = false
                    let constraint = builder(view, superview)
                    constraint.identifier = "\(id.identifier).\(name)"
                    superview.addConstraint(constraint)
                }
            }
        }
    }

    public static func centerX<T: UIView>() -> Property<T> {
        return constraint("centerX") { view, superview in
            return NSLayoutConstraint(
                item: view,
                attribute: .CenterX,
                relatedBy: .Equal,
                toItem: superview,
                attribute: .CenterX,
                multiplier: 1.0,
                constant: 0
            )
        }
    }

    public static func centerY<T: UIView>() -> Property<T> {
        return constraint("centerY") { view, superview in
            NSLayoutConstraint(
                item: view,
                attribute: .CenterY,
                relatedBy: .Equal,
                toItem: superview,
                attribute: .CenterY,
                multiplier: 1.0,
                constant: 0
            )
        }
    }

    public static func pinLeft<T: UIView>() -> Property<T> {
        return constraint("pinLeft") { view, superview in
            NSLayoutConstraint(
                item: view,
                attribute: .Left,
                relatedBy: .Equal,
                toItem: superview,
                attribute: .Left,
                multiplier: 1.0,
                constant: 0
            )
        }
    }

    public static func pinRight<T: UIView>() -> Property<T> {
        return constraint("pinRight") { view, superview in
            NSLayoutConstraint(
                item: view,
                attribute: .Right,
                relatedBy: .Equal,
                toItem: superview,
                attribute: .Right,
                multiplier: 1.0,
                constant: 0
            )
        }
    }

    public static func pinTop<T: UIView>() -> Property<T> {
        return constraint("pinTop") { view, superview in
            NSLayoutConstraint(
                item: view,
                attribute: .Top,
                relatedBy: .Equal,
                toItem: superview,
                attribute: .Top,
                multiplier: 1.0,
                constant: 0
            )
        }
    }

    public static func pinBottom<T: UIView>() -> Property<T> {
        return constraint("pinBottom") { view, superview in
            NSLayoutConstraint(
                item: view,
                attribute: .Bottom,
                relatedBy: .Equal,
                toItem: superview,
                attribute: .Bottom,
                multiplier: 1.0,
                constant: 0
            )
        }
    }
}
