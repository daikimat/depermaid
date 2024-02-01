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
        var flowchart = Flowchart(direction: .TD)
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
    
    func testFlowChartDirectionToString() {
        let flowchartBT = Flowchart(direction: .BT)
        
        let actualBT = """
        ```mermaid
        flowchart BT
        ```
        """
        XCTAssertEqual(flowchartBT.toString(), actualBT)
        
        let flowchartLR = Flowchart(direction: .LR)
        
        let actualLR = """
        ```mermaid
        flowchart LR
        ```
        """
        XCTAssertEqual(flowchartLR.toString(), actualLR)
        
        let flowchartRL = Flowchart(direction: .RL)
        
        let actualRL = """
        ```mermaid
        flowchart RL
        ```
        """
        XCTAssertEqual(flowchartRL.toString(), actualRL)
        
        let flowchartTB = Flowchart(direction: .TB)
        
        let actualTB = """
        ```mermaid
        flowchart TB
        ```
        """
        XCTAssertEqual(flowchartTB.toString(), actualTB)
        
        let flowchartTD = Flowchart(direction: .TD)
        
        let actualTD = """
        ```mermaid
        flowchart TD
        ```
        """
        XCTAssertEqual(flowchartTD.toString(), actualTD)
    }
    
}
