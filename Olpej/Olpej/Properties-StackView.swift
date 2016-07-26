extension Property {
    public static func alignment(value: UIStackViewAlignment) -> Property<UIStackView> {
        return Property<UIStackView>("stackview.alignment", value.hashValue) { mode, view in
            switch(mode) {
            case .remove: view.alignment = .Fill
            case .update: view.alignment = value
            }
        }
    }

    public static func axis(value: UILayoutConstraintAxis) -> Property<UIStackView> {
        return Property<UIStackView>("stackview.axis", value.hashValue) { mode, view in
            switch(mode) {
            case .remove: view.axis = .Horizontal
            case .update: view.axis = value
            }
        }
    }

    public static func baselineRelativeArrangement(value: Bool) -> Property<UIStackView> {
        return Property<UIStackView>("stackview.baselineRelativeArrangement", value.hashValue) { mode, view in
            switch(mode) {
            case .remove: view.baselineRelativeArrangement = false
            case .update: view.baselineRelativeArrangement = value
            }
        }
    }

    public static func distribution(value: UIStackViewDistribution) -> Property<UIStackView> {
        return Property<UIStackView>("stackview.distribution", value.hashValue) { mode, view in
            switch(mode) {
            case .remove: view.distribution = .Fill
            case .update: view.distribution = value
            }
        }
    }

    public static func layoutMarginsRelativeArrangement(value: Bool) -> Property<UIStackView> {
        return Property<UIStackView>("stackview.layoutMarginsRelativeArrangement", value.hashValue) { mode, view in
            switch(mode) {
            case .remove: view.layoutMarginsRelativeArrangement = false
            case .update: view.layoutMarginsRelativeArrangement = value
            }
        }
    }

    public static func spacing(value: CGFloat) -> Property<UIStackView> {
        return Property<UIStackView>("stackview.spacing", value.hashValue) { mode, view in
            switch(mode) {
            case .remove: view.spacing = 0.0
            case .update: view.spacing = value
            }
        }
    }
}
