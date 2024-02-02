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

    func createFlowchart(
        direction: Direction
    ) -> Flowchart {
        var flowchart = Flowchart(direction: direction)
        for (firstNode, secondNodes) in dependencies.sorted(by: { $0.key.id < $1.key.id }) {
            if secondNodes.isEmpty {
                flowchart.append(firstNode)
            }
            for secondNode in secondNodes.sorted(by: { $0.id < $1.id }) {
                flowchart.append(firstNode, secondNode)
            }
        }
        return flowchart
    }

    func filterDuplicateDependencies() -> DependencyTree {
        var filteredDependencies: [Node: Set<Node>] = [:]

        for (parentNode, childrenNode) in dependencies {
            filteredDependencies[parentNode] = Set<Node>()
            var filteredChildrenNodes = childrenNode
            for childNode in filteredChildrenNodes {
                if childNode == parentNode {
                    continue
                }
                let otherChildNodes = filteredChildrenNodes.subtracting([childNode])
                for otherNode in otherChildNodes {
                    if find(of: otherNode, startingFrom: childNode, ignore: parentNode) {
                        filteredChildrenNodes.remove(otherNode)
                        continue
                    }
                }
                filteredDependencies[parentNode] = filteredChildrenNodes
            }
        }

        return DependencyTree(dependencies: filteredDependencies)
    }

    private func find(of target: Node, startingFrom source: Node, ignore: Node) -> Bool {
        if dependencies[source] == nil {
            return false
        }

        var visitedNodes: Set<Node> = []
        var depthQueue: [Node] = []

        depthQueue.append(source)
        visitedNodes.insert(source)

        while !depthQueue.isEmpty {
            let current = depthQueue.removeFirst()
            if current == ignore {
                continue
            }

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
