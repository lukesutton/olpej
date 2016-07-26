import Foundation

public enum PatchOperation<V: UIView> {
    case RemovePropertys([Property<V>])
    case UpdatePropertys([Property<V>])
}

public func diff<A>(from: Component<A>, _ to: Component<A>) -> [PatchOperation<A>] {
    if from == to {
        return []
    }
    else {
        var results = Array<PatchOperation<A>>()
        
        // Find any that need to be removed
        let toTags = to.attributes.map {$0.tag}
        let removals = from.attributes.filter {!toTags.contains($0.tag)}
        if !removals.isEmpty {
            results.append(PatchOperation<A>.RemovePropertys(removals))
        }
        
        // Find attributes that need updating
        let updates = to.attributes.subtract(from.attributes)
        if !updates.isEmpty {
            results.append(PatchOperation<A>.UpdatePropertys(Array(updates)))
        }
        
        return results
    }
}

public func apply<V>(patches patches: [PatchOperation<V>], to view: V) {
    for operations in patches {
        switch(operations) {
        case let .RemovePropertys(attrs):
            for attr in attrs {
                attr.update(.remove, view)
            }
        case let .UpdatePropertys(attrs):
            for attr in attrs {
                attr.update(.update, view)
            }
        }
    }
}

public func apply(layout layout: String, views: [UIView]) {

}
