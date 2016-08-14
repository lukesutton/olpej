extension Property {
    public static func title(value: String? = nil, forState state: UIControlState) -> Property<UIButton> {
        let hashValue = (value?.hashValue ?? 0) + Int(state.rawValue)
        return Property<UIButton>("uibutton.title", hashValue) { _, mode, view in
            switch(mode) {
            case .remove: view.setTitle(nil, forState: state)
            case .update: view.setTitle(value, forState: state)
            }
        }
    }
}
