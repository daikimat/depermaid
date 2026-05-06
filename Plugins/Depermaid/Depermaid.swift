import PackagePlugin

@main
struct Depermaid: CommandPlugin {
    func performCommand(context: PluginContext, arguments: [String]) async throws {
        var argExtractor = ArgumentExtractor(arguments)
        if argExtractor.extractFlag(named: "help") > 0 {
            print(
                """
                USAGE: swift package depermaid

                OPTIONS:
                  --direction <direction> Specify the direction for the Mermaid diagram.
                                          Available options:
                                            TB - Top to bottom
                                            TD - Top-down/ same as top to bottom
                                            BT - Bottom to top
                                            LR - Left to right
                                            RL - Right to left
                                            Default: LR
                  --test                  Include .testTarget(name:...)
                  --executable            Include .executableTarget(name:...)
                  --product               Include .product(name:...)
                  --include-macro         Include .macro(name:...)
                  --minimal               Generate a minimal Mermaid diagram by including only essential dependencies.
                  --help                  Show help information.
                """
            )
            return
        }

        let dependencyTree = createDependencyTree(
            from: context.package.sourceModules,
            includeTest: (argExtractor.extractFlag(named: "test") > 0),
            includeExecutable: (argExtractor.extractFlag(named: "executable") > 0),
            includeProduct: (argExtractor.extractFlag(named: "product") > 0),
            includeMacro: (argExtractor.extractFlag(named: "include-macro") > 0)
        )

        let direction = Direction(
            rawValue:(argExtractor.extractOption(named: "direction").first ?? "").uppercased()
        ) ?? Direction.LR
        let flowchart: Flowchart
        if argExtractor.extractFlag(named: "minimal") > 0 {
            flowchart = dependencyTree.filterDuplicateDependencies().createFlowchart(direction: direction)
        } else {
            flowchart = dependencyTree.createFlowchart(direction: direction)
        }
        print(flowchart.toString())
    }

    private func createDependencyTree(
        from sourceModules: [SourceModuleTarget],
        includeTest: Bool,
        includeExecutable: Bool,
        includeProduct: Bool,
        includeMacro: Bool
    ) -> DependencyTree {
        var dependencyTree = DependencyTree()
        let includedModules = sourceModules
            .filter { module in
                return  switch (module.kind) {
                case .generic:
                    true

                case .executable:
                    includeExecutable

                case .test:
                    includeTest

                case .snippet:
                    false

                case .macro:
                    includeMacro

                @unknown default:
                    fatalError("unknown kind")
                }
            }
        let includedModuleNames = Set(includedModules.map(\.name))
        includedModules
            .forEach { module in
                switch (module.kind) {
                case .generic:
                    dependencyTree.addDependency(from: Node(module.name))

                case .executable:
                    dependencyTree.addDependency(from: Node(module.name, shape: .stadium))

                case .test:
                    dependencyTree.addDependency(from: Node(module.name, shape: .hexagon))

                case .snippet:
                    break

                case .macro:
                    dependencyTree.addDependency(from: Node(module.name, shape: .parallelogram))

                @unknown default:
                    fatalError("unknown kind")
                }

                module.dependencies
                    .filter { dependencies in
                        switch dependencies {
                        case let .target(target):
                            includedModuleNames.contains(target.name)

                        case .product(_):
                            includeProduct

                        @unknown default:
                            fatalError("unknown type dependencies")
                        }
                    }
                    .forEach { dependencies in
                        switch dependencies {
                        case let .target(target):
                            dependencyTree.addDependency(from: Node(module.name), to: Node(target.name))

                        case let .product(product):
                            dependencyTree.addDependency(from: Node(module.name), to: Node(product.name, shape: .subroutine))

                        @unknown default:
                            fatalError("unknown type dependencies")
                        }
                    }
            }
        return dependencyTree
    }
}
