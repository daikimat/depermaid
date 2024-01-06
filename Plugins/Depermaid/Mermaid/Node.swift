//
//  Node.swift
//  
//
//  Created by daiki-matsumoto on 2024/01/07.
//

struct Node {
    let id: String
    let text: String
    let shape: NodeShape
    
    init(text: String, shape: NodeShape = .square) {
        self.id = text
        self.text = text
        self.shape = shape
    }
    
}

extension Node {
    func toString() -> String {
        return switch(shape) {
        case .square:
            text
        case .subroutine:
            "\(id)[[\(text)]]"
        case .hexagon:
            "\(id){{\(text)}}"
        }
    }
}
