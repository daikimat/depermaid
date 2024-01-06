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
        let includeTest = (argExtractor.extractFlag(named: "include-test") > 0)
        let includeProduct = (argExtractor.extractFlag(named: "include-product") > 0)

        var flowchart = Flowchart()
        context.package.sourceModules
            .filter({ module in
                return module.kind != .test || includeTest
            }).forEach { module in
                let moduleName = module.name
                if module.kind != .test {
                    flowchart.append(FlowchartItem(Node(text: moduleName)))
                } else {
                    flowchart.append(FlowchartItem(Node(text: moduleName, shape: .hexagon)))
                }
                
                module.dependencies
                    .forEach { moduleDependencies in
                        switch moduleDependencies {
                        case let .product(product):
                            if includeProduct {
                                flowchart.append(FlowchartItem(Node(text: moduleName), Node(text: product.name, shape: .subroutine)))
                            }
                            
                        case let .target(target):
                            flowchart.append(FlowchartItem(Node(text: moduleName), Node(text: target.name)))
                            
                        @unknown default:
                            fatalError("unknown type dependencies")
                        }
                    }
            }
        print(flowchart.toMermaidBlock())
    }
}
