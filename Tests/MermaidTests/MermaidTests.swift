//
//  MermaidTests.swift
//
//
//  Created by daiki-matsumoto on 2024/01/08.
//

import XCTest

final class MermaidTests: XCTestCase {
    func testNodeToString() {
        let normalNode = Node("normalNode")
        let normalNodeActual = "normalNode"
        XCTAssertEqual(normalNode.toString(), normalNodeActual)
        
        let normalNodeWithShape = Node("normalNodeWithShape", shape: .square)
        let normalNodeWithShapeActual = "normalNodeWithShape"
        XCTAssertEqual(normalNodeWithShape.toString(), normalNodeWithShapeActual)
        
        let hexagonNode = Node("hexagonNode", shape: .hexagon)
        let hexagonNodeActual = "hexagonNode{{hexagonNode}}"
        XCTAssertEqual(hexagonNode.toString(), hexagonNodeActual)

        let subroutineNode = Node("subroutineNode", shape: .subroutine)
        let subroutineNodeActual = "subroutineNode[[subroutineNode]]"
        XCTAssertEqual(subroutineNode.toString(), subroutineNodeActual)
    }

    func testFlowChartItemToString() {
        let normalNode = Node("normalNode")
        let normalNodeOnlyflowchartItem = FlowchartItem(normalNode)
        let normalNodeOnlyflowchartItemActual = "normalNode"
        XCTAssertEqual(normalNodeOnlyflowchartItem.toString(), normalNodeOnlyflowchartItemActual)

        let hexagonNode = Node("hexagonNode", shape: .hexagon)
        let linkedNodeflowchartItem = FlowchartItem(normalNode, hexagonNode)
        let linkedNodeflowchartItemActual = "normalNode-->hexagonNode{{hexagonNode}}"
        XCTAssertEqual(linkedNodeflowchartItem.toString(), linkedNodeflowchartItemActual)
    }
    
    func testFlowChartToString() {
        var flowchart = Flowchart()
        flowchart.append(Node("test1"))
        flowchart.append(Node("test2"))
        flowchart.append(Node("test2"), Node("test3"))

        let actual = """
        ```mermaid
        flowchart TD
            test1
            test2
            test2-->test3
        ```
        """
        XCTAssertEqual(flowchart.toString(), actual)
    }
}
