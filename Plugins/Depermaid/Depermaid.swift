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
                                            RL - Right to left
                                            LR - Left to right
                                            Default: TD
                  --test                  Include .testTarget(name:...)
                  --executable            Include .executableTarget(name:...)
                  --product               Include .product(name:...)
                  --help                  Show help information.
                """
            )
            return
        }

        let direction = Direction(rawValue: argExtractor.extractOption(named: "direction").first ?? "") ?? Direction.TD
        let flowchart = createFlowchart(
            from: context.package.sourceModules,
            direction: direction,
            includeTest: (argExtractor.extractFlag(named: "test") > 0),
            includeExecutable: (argExtractor.extractFlag(named: "executable") > 0),
            includeProduct: (argExtractor.extractFlag(named: "product") > 0)
        )
        print(flowchart.toString())
    }
    
    private func createFlowchart(
        from sourceModules: [SourceModuleTarget],
        direction: Direction,
        includeTest: Bool,
        includeExecutable: Bool,
        includeProduct: Bool
    ) -> Flowchart {
        var flowchart = Flowchart(direction: direction)
        sourceModules
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
                    false

                @unknown default:
                    fatalError("unknown kind")
                }
            }
            .forEach { module in
                var shape: NodeShape? = nil
                switch (module.kind) {
                case .generic:
                    break

                case .executable:
                    shape = .stadium

                case .test:
                    shape = .hexagon

                case .snippet:
                    break

                case .macro:
                    break

                @unknown default:
                    fatalError("unknown kind")
                }
                flowchart.append(Node(module.name, shape: shape))

                module.dependencies
                    .filter { dependencies in
                        if case .product(_) = dependencies {
                            return includeProduct
                        }
                        return true
                    }
                    .forEach { dependencies in
                        switch dependencies {
                        case let .product(product):
                            flowchart.append(Node(module.name), Node(product.name, shape: .subroutine))

                        case let .target(target):
                            flowchart.append(Node(module.name), Node(target.name))

                        @unknown default:
                            fatalError("unknown type dependencies")
                        }
                    }
            }
        return flowchart
    }
}
