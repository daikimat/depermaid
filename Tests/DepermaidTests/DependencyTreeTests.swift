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

        var expect = Flowchart(direction: .LR)
        expect.append(nodeA, nodeB)
        expect.append(nodeA, nodeC)
        expect.append(nodeB)
        expect.append(nodeC, nodeA)

        XCTAssertEqual(sut.createFlowchart(direction: .LR), expect)
    }

    func testFilterDuplicateDependencies() {
        var dependencyTree = DependencyTree()
        let nodeA = Node("A")
        let nodeB = Node("B")
        let nodeC = Node("C")
        let nodeD = Node("D")
        dependencyTree.addDependency(from: nodeD)
        dependencyTree.addDependency(from: nodeC, to: nodeD)
        dependencyTree.addDependency(from: nodeB, to: nodeD)
        dependencyTree.addDependency(from: nodeB, to: nodeC)
        dependencyTree.addDependency(from: nodeA, to: nodeD)
        dependencyTree.addDependency(from: nodeA, to: nodeC)
        dependencyTree.addDependency(from: nodeA, to: nodeB)

        let sut = dependencyTree.filterDuplicateDependencies()

        XCTAssertEqual(sut.dependencies, [
            nodeA: [nodeB],
            nodeB: [nodeC],
            nodeC: [nodeD],
            nodeD: [],
        ])
    }

    func testFilterDuplicateDependencies_loop_pattern() {
        var dependencyTree = DependencyTree()
        let nodeA = Node("A")
        let nodeB = Node("B")
        let nodeC = Node("C")
        let nodeD = Node("D")
        dependencyTree.addDependency(from: nodeA, to: nodeC)
        dependencyTree.addDependency(from: nodeA, to: nodeD)
        dependencyTree.addDependency(from: nodeC, to: nodeA)
        dependencyTree.addDependency(from: nodeB, to: nodeD)
        dependencyTree.addDependency(from: nodeA, to: nodeB)

        let sut = dependencyTree.filterDuplicateDependencies()

        XCTAssertEqual(sut.dependencies, [
            nodeA: [nodeB, nodeC],
            nodeB: [nodeD],
            nodeC: [nodeA],
        ])
    }
}
