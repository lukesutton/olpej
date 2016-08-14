import Foundation

public struct Style<V: UIView> {
    let label: String
    let properties: [Property<V>]
}
