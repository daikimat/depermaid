//
//  MermaidTests.swift
//
//
//  Created by daiki-matsumoto on 2024/01/08.
//

import XCTest

final class MermaidTests: XCTestCase {
    func testNodeToString() {
        let idOnlyNode = Node("normalNode")
        let idOnlyNodeActual = "normalNode"
        XCTAssertEqual(idOnlyNode.toString(), idOnlyNodeActual)

        let squareNode = Node("squareNode", shape: .square)
        let squareNodeActual = "squareNode[squareNode]"
        XCTAssertEqual(squareNode.toString(), squareNodeActual)

        let stadiumNode = Node("squareNode", shape: .stadium)
        let stadiumNodeActual = "squareNode([squareNode])"
        XCTAssertEqual(stadiumNode.toString(), stadiumNodeActual)

        let subroutineNode = Node("subroutineNode", shape: .subroutine)
        let subroutineNodeActual = "subroutineNode[[subroutineNode]]"
        XCTAssertEqual(subroutineNode.toString(), subroutineNodeActual)

        let hexagonNode = Node("hexagonNode", shape: .hexagon)
        let hexagonNodeActual = "hexagonNode{{hexagonNode}}"
        XCTAssertEqual(hexagonNode.toString(), hexagonNodeActual)
    }

    func testFlowChartItemToString() {
        let normalNode = Node("normalNode")
        let normalNodeOnlyFlowchartItem = FlowchartItem(normalNode)
        let normalNodeOnlyFlowchartItemActual = "normalNode"
        XCTAssertEqual(normalNodeOnlyFlowchartItem.toString(), normalNodeOnlyFlowchartItemActual)

        let hexagonNode = Node("hexagonNode", shape: .hexagon)
        let linkedNodeFlowchartItem = FlowchartItem(normalNode, hexagonNode)
        let linkedNodeFlowchartItemActual = "normalNode-->hexagonNode{{hexagonNode}}"
        XCTAssertEqual(linkedNodeFlowchartItem.toString(), linkedNodeFlowchartItemActual)
    }

    func testFlowChartToString() {
        var flowchart = Flowchart(direction: .TD)
        flowchart.append(Node("test1"))
        flowchart.append(Node("test2"))
        flowchart.append(Node("test2"), Node("test3"))

        let actual = """
        flowchart TD
            test1
            test2
            test2-->test3
        """
        XCTAssertEqual(flowchart.toString(), actual)
    }

    func testFlowChartDirectionToString() {
        let flowchartBT = Flowchart(direction: .BT)

        let actualBT = """
        flowchart BT
        """
        XCTAssertEqual(flowchartBT.toString(), actualBT)

        let flowchartLR = Flowchart(direction: .LR)

        let actualLR = """
        flowchart LR
        """
        XCTAssertEqual(flowchartLR.toString(), actualLR)

        let flowchartRL = Flowchart(direction: .RL)

        let actualRL = """
        flowchart RL
        """
        XCTAssertEqual(flowchartRL.toString(), actualRL)

        let flowchartTB = Flowchart(direction: .TB)

        let actualTB = """
        flowchart TB
        """
        XCTAssertEqual(flowchartTB.toString(), actualTB)

        let flowchartTD = Flowchart(direction: .TD)

        let actualTD = """
        flowchart TD
        """
        XCTAssertEqual(flowchartTD.toString(), actualTD)
    }
}
