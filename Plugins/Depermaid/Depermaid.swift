import PackagePlugin

@main
struct Depermaid: CommandPlugin {
    func performCommand(context: PluginContext, arguments: [String]) async throws {
        var argExtractor = ArgumentExtractor(arguments)
        if argExtractor.extractFlag(named: "help") > 0 {
            print(
                """
                USAGE: swift package depermaid [--include-test] [--include-product]

                OPTIONS:
                  --include-test          Include .testTarget(name:dependencies:path:exclude:sources:)
                  --include-product       Include .product(name:package:)
                  --help                  Show help information.
                """
            )
            return
        }

        let flowchart = createFlowchart(
            from: context.package.sourceModules,
            includeTest: (argExtractor.extractFlag(named: "include-test") > 0),
            includeProduct: (argExtractor.extractFlag(named: "include-product") > 0)
        )
        print(flowchart.toString())
    }
    
    private func createFlowchart(
        from sourceModules: [SourceModuleTarget],
        includeTest: Bool,
        includeProduct: Bool
    ) -> Flowchart {
        var flowchart = Flowchart()
        sourceModules
            .filter { module in
                return module.kind != .test || includeTest
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
