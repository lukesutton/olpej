extension Property {
    public static func text<T: UILabel>(value: String) -> Property<T> {
        return Property<T>("label.text", value.hashValue) { mode, view in
            switch(mode) {
            case .remove: view.text = nil
            case .update: view.text = value
            }
        }
    }

    public static func attributedText<T: UILabel>(value: NSAttributedString) -> Property<T> {
        return Property<T>("label.attributedText", value.hashValue) { mode, view in
            switch(mode) {
            case .remove: view.attributedText = nil
            case .update: view.attributedText = value
            }
        }
    }

    public static func font<T: UILabel>(value: UIFont) -> Property<T> {
        return Property<T>("label.font", value.hashValue) { mode, view in
            switch(mode) {
            case .remove: view.font = nil
            case .update: view.font = value
            }
        }
    }

    public static func textColor<T: UILabel>(color: UIColor) -> Property<T> {
        return Property<T>("label.font", color.hashValue) { mode, view in
            switch(mode) {
            case .remove: view.textColor = nil
            case .update: view.textColor = color
            }
        }
    }

    public static func textAlignment<T: UILabel>(alignment: NSTextAlignment) -> Property<T> {
        return Property<T>("label.font", alignment.hashValue) { mode, view in
            switch(mode) {
            case .remove: view.textAlignment = .Left
            case .update: view.textAlignment = alignment
            }
        }
    }

    public static func lineBreakMode<T: UILabel>(breakMode: NSLineBreakMode) -> Property<T> {
        return Property<T>("label.font", breakMode.hashValue) { mode, view in
            switch(mode) {
            case .remove: view.lineBreakMode = .ByTruncatingTail
            case .update: view.lineBreakMode = breakMode
            }
        }
    }
}