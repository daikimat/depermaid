//
//  DependencyTree.swift
//  
//
//  Created by daiki-matsumoto on 2024/01/31.
//

struct DependencyTree {
    var dependencies: [Node: Set<Node>] = [:]
    
    mutating func addDependency(from source: Node, to destination: Node? = nil) {
        if dependencies[source] == nil {
            dependencies[source] = Set<Node>()
        }
        if let destination = destination {
            dependencies[source]?.insert(destination)
        }
    }
}
