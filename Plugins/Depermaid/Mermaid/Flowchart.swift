//
//  Flowchart.swift
//
//
//  Created by daiki-matsumoto on 2024/01/07.
//

struct Flowchart: Equatable {
    let direction: Direction
    var items: [FlowchartItem] = []

    init(direction: Direction) {
        self.direction = direction
    }

    mutating func append(_ firstNode: Node, _ secondNode: Node? = nil) {
        self.items.append(FlowchartItem(firstNode, secondNode))
    }

    func toString() -> String{
        var mermaid = "```mermaid"
        mermaid.newLine("flowchart \(self.direction)")
        items.forEach { item in
            mermaid.newLine(item.toString(), indent: 1)
        }
        mermaid.newLine("```")
        return mermaid
    }
}

extension String {
    mutating fileprivate func newLine(_ new: String, indent: Int = 0) {
        self = self + "\n" + String(repeating: "    ", count: indent) + new
    }
}
