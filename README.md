# depermaid - Swift Package Plugin

[depermaid](https://example.com/depermaid) is a Swift Package Manager plugin that generates [Mermaid](https://mermaid-js.github.io/mermaid/) diagrams representing dependencies within your Swift package.

## Usage

1. Add the following line to your `Package.swift` file in the `dependencies` section:

    ```swift
    dependencies: [
        .package(url: "https://github.com/daikimat/depermaid.git", from: "1.0.0")
    ],
    ```

2. Run the following command in the same directory as your `Package.swift` file:

    ```bash
    $ swift package plugin depermaid --help
    ```
    This will display the available options:

    ```bash
    USAGE: swift package depermaid [--test] [--executable] [--product]

    OPTIONS:
      --test         Include .testTarget(name:...)
      --executable   Include .executableTarget(name:...)
      --product      Include .product(name:...)
      --help         Show help information.
    ```

### Basic Usage
```bash
$ swift package plugin depermaid
```
```mermaid
flowchart TD
    Example
    Example-->Cat
    Example-->Dog
    Dog
    Dog-->AnimalClient
    Cat
    Cat-->AnimalClient
    AnimalClient
```

### Including Test Targets
```bash
$ swift package plugin depermaid --test
```
```mermaid
flowchart TD
    Example
    Example-->Cat
    Example-->Dog
    Dog
    Dog-->AnimalClient
    Cat
    Cat-->AnimalClient
    AnimalClientTests{{AnimalClientTests}}
    AnimalClientTests-->AnimalClient
    AnimalClient
```
### Including Executable Targets
```bash
$ swift package plugin depermaid --executable
```
```mermaid
flowchart TD
    ExecutableExample([ExecutableExample])
    ExecutableExample-->Dog
    Example
    Example-->Cat
    Example-->Dog
    Dog
    Dog-->AnimalClient
    Cat
    Cat-->AnimalClient
    AnimalClient
```

### Including Products
```bash
$ swift package plugin depermaid --product
```
```mermaid
flowchart TD
    Example
    Example-->Cat
    Example-->Dog
    Dog
    Dog-->AnimalClient
    Cat
    Cat-->AnimalClient
    AnimalClient
    AnimalClient-->LifeCore[[LifeCore]]
```

### Including All
```bash
$ swift package plugin depermaid --test --executable --product
```
```mermaid
flowchart TD
    ExecutableExample([ExecutableExample])
    ExecutableExample-->Dog
    Example
    Example-->Cat
    Example-->Dog
    Dog
    Dog-->AnimalClient
    Cat
    Cat-->AnimalClient
    AnimalClientTests{{AnimalClientTests}}
    AnimalClientTests-->AnimalClient
    AnimalClient
    AnimalClient-->LifeCore[[LifeCore]]
```

Feel free to customize the command options according to your specific use case.

## Examples

To demonstrate the capabilities of Depermaid, a sample project is provided in the `./Example/ExampleDepermaid.xcodeproj`.

### Expected Behavior

Upon successful build and run, Depermaid will analyze the Swift package dependencies in the example project and generate a Mermaid-format graph. This graph will be automatically reflected in this README file, demonstrating the integration of Depermaid to visualize Swift package dependencies.Please refer to this README file when reviewing the generated graph.
The mechanism behind the automatic update of the README file during the build process is implemented using a custom script added to the Xcode project's Build Phases. 

### Build and Run the Example

Follow these steps to build and run the example project:

1. Open the Xcode project:

   ```bash
   open ./Example/ExampleDepermaid.xcodeproj
   ```

2. Make changes to the `./Example/Package.swift` file as needed.

3. Build and run the project from Xcode.

After the build process, please review this README file to see the updated graph reflecting the changes made to the Swift package dependencies.

## License

Depermaid is released under the [MIT License](LICENSE).