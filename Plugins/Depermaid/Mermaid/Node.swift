//
//  Node.swift
//
//
//  Created by daiki-matsumoto on 2024/01/07.
//

struct Node {
    let id: String
    let shape: NodeShape?

    init(_ id: String, shape: NodeShape? = nil) {
        self.id = id
        self.shape = shape
    }

    func toString() -> String {
        guard let shape = shape else {
            return id
        }
        return switch(shape) {
        case .square:
            "\(id)[\(id)]"
        case .stadium:
            "\(id)([\(id)])"
        case .subroutine:
            "\(id)[[\(id)]]"
        case .hexagon:
            "\(id){{\(id)}}"
        }
    }
}

extension Node: Equatable {
    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Node: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
