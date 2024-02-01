//
//  DependencyTreeTests.swift
//
//
//  Created by daiki-matsumoto on 2024/02/01.
//

import XCTest

final class DependencyTreeTests: XCTestCase {
    func testAddDependency() {
        var sut = DependencyTree()
        let nodeA = Node("A")
        let nodeB = Node("B")
        let nodeC = Node("C")
        sut.addDependency(from: nodeA, to: nodeC)
        sut.addDependency(from: nodeC, to: nodeA)
        sut.addDependency(from: nodeB)
        sut.addDependency(from: nodeA, to: nodeB)

        XCTAssertEqual(sut.dependencies, [
            nodeA: [nodeB, nodeC],
            nodeB: [],
            nodeC: [nodeA],
        ])
    }
    
    func testCreateFlowchart_sorted_alphabetically() {
        var sut = DependencyTree()
        let nodeA = Node("A")
        let nodeB = Node("B")
        let nodeC = Node("C")
        sut.addDependency(from: nodeA, to: nodeC)
        sut.addDependency(from: nodeC, to: nodeA)
        sut.addDependency(from: nodeB)
        sut.addDependency(from: nodeA, to: nodeB)

        var flowchart = Flowchart(direction: .LR)
        flowchart.append(nodeA, nodeB)
        flowchart.append(nodeA, nodeC)
        flowchart.append(nodeB)
        flowchart.append(nodeC, nodeA)

        XCTAssertEqual(sut.createFlowchart(direction: .LR), flowchart)
    }
}
