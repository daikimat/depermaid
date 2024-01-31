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
    
    func filterTransitiveDependencies() -> DependencyTree {
        var filteredDependencies: [Node: Set<Node>] = [:]
        
        for (parentNode, childrenNode) in dependencies {
            filteredDependencies[parentNode] = Set<Node>()
            var filterdChildrenNodes = childrenNode
            for childNode in filterdChildrenNodes {
                if childNode == parentNode {
                    continue
                }
                var otherChildNodes = filterdChildrenNodes.subtracting([childNode])
                for otherNode in otherChildNodes {
                    if find(of: otherNode, startingFrom: childNode) {
                        filterdChildrenNodes.remove(otherNode)
                        continue
                    }
                }
                filteredDependencies[parentNode] = filterdChildrenNodes
            }
        }
        
        return DependencyTree(dependencies: filteredDependencies)
    }
    
    private func find(of target: Node, startingFrom source: Node) -> Bool {
        guard let dependenciesOfSource = dependencies[source] else {
            return false
        }
        
        var visitedNodes: Set<Node> = []
        var depthQueue: [Node] = []
        
        depthQueue.append(source)
        visitedNodes.insert(source)
        
        while !depthQueue.isEmpty {
            let current = depthQueue.removeFirst()
            
            if current == target {
                return true
            }
            
            if let dependenciesOfCurrent = dependencies[current] {
                for nextNode in dependenciesOfCurrent {
                    if !visitedNodes.contains(nextNode) {
                        visitedNodes.insert(nextNode)
                        depthQueue.append(nextNode)
                    }
                }
            }
        }
        
        return false
    }
}
