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

        var mermaid = "```mermaid"
        mermaid.newLine("graph TD;")
        context.package.sourceModules.forEach { module in
            let moduleName = module.name
            if module.kind != .test || includeTest {
                if module.kind != .test {
                    mermaid.newLine("\(moduleName);", indent: 1)
                } else {
                    mermaid.newLine("\(moduleName){{\(moduleName)}};", indent: 1)
                }

                module.dependencies.forEach { moduleDependencies in
                    switch moduleDependencies {
                    case let .product(product):
                        if includeProduct {
                            mermaid.newLine("\(moduleName)-->\(product.name)[[\(product.name)]];", indent: 1)
                        }

                    case let .target(target):
                        mermaid.newLine("\(moduleName)-->\(target.name);", indent: 1)

                    @unknown default:
                        fatalError("unknown type dependencies")
                    }
                }
            }
        }
        mermaid.newLine("```")
        print(mermaid)
    }
}

extension String {
    mutating func newLine(_ new: String, indent: Int = 0) {
        self = self + "\n" + String(repeating: "    ", count: indent) + new
    }
}
