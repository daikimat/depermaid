//
//  Node.swift
//  
//
//  Created by daiki-matsumoto on 2024/01/07.
//

struct Node: Hashable, Equatable {
    let id: String
    let shape: NodeShape?
    
    init(_ id: String, shape: NodeShape? = nil) {
        self.id = id
        self.shape = shape
    }
    
    static func == (lhs: Node, rhs: Node) -> Bool{
        return lhs.id == rhs.id
    }
}

extension Node {
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
