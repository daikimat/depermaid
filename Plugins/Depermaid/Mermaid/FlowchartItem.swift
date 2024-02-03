//
//  FlowchartItem.swift
//
//
//  Created by daiki-matsumoto on 2024/01/07.
//

struct FlowchartItem: Equatable {
    let firstNode: Node
    let secondNode: Node?
    init(_ firstNode: Node, _ secondNode: Node? = nil) {
        self.firstNode = firstNode
        self.secondNode = secondNode
    }
}

extension FlowchartItem {
    func toString() -> String {
        var string = firstNode.toString()
        if let secondNode = secondNode {
            string += "-->\(secondNode.toString())"
        }
        return string
    }
}
