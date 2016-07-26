extension UIView {
    // An alias for adding subviews. This is here so that we can override it
    // for classes like stacks which use a different function.
    func op_addSubview(view: UIView) {
        addSubview(view)
    }
}
