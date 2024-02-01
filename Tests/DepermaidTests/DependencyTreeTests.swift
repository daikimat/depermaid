//
//  DependencyTreeTests.swift
//
//
//  Created by daiki-matsumoto on 2024/02/01.
//

import XCTest

final class DependencyTreeTests: XCTestCase {
    func testHoge() {
        var sut = DependencyTree()
        let node = Node("aa")
        sut.addDependency(from: node)
        XCTAssertEqual(sut.dependencies, [node: []])
    }
}
