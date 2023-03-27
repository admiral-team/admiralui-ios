import Foundation

@main
public struct CreateXCFramework {

    // MARK: - Constants

    private enum Constants {
        static let schemeName = "swift-snapshot-testing"
        static let inputPath = "swift-snapshot-testing"
        static let outputPath = "LocalDependencies"
    }

    // MARK: - Main

    public static func main() throws {
        let frameWorkBulder = CreateXCFramework()
        let rootPath = FileManager.default.currentDirectoryPath
        let inputPath = rootPath + "/" + Constants.inputPath
        let outputPath = frameWorkBulder.generateUrl(for: rootPath, with: Constants.outputPath)
        
        let builder = CommandBuilder(
            scheme: Constants.schemeName,
            path: inputPath,
            outputPath: outputPath,
            enableLibraryEvolution: false,
            rootPath: rootPath,
            platforms: [.simulator, .ios]
        )

        frameWorkBulder.downloadSnapShot(with: builder)
        frameWorkBulder.createXCFrameworks(with: builder)
    }

    // MARK: - Private Methods

    private func downloadSnapShot(with commandBuilder: CommandBuilder) {
        execute(commandBuilder.downloadLibCommand)
    }

    private func createXCFrameworks(with commandBuilder: CommandBuilder) {
        execute(commandBuilder.cleanCommand)
        commandBuilder.buildCommands.forEach { execute($0) }
        commandBuilder.createFoldersCommands.forEach { execute($0) }
        let platform = commandBuilder.platforms.first ?? .ios
        let frameworkNames = frameworkNames(from: commandBuilder.frameworkNamesCommand(for: platform))

        commandBuilder.platforms.forEach { platform in
            frameworkNames.forEach { name in
                execute(commandBuilder.createFrameworkCommand(frameworkName: name, platform: platform))
            }
        }

        print("Creating XCFrameworks")
        frameworkNames.forEach { name in
            execute(commandBuilder.xcframeworkCommand(for: name))
            execute(commandBuilder.copyResourcesCommand(for: name, platfrom: platform))
        }

        execute(commandBuilder.cleanupCommand)
        print("Finished")
        execute(commandBuilder.openFolderCommand)
    }

    private func frameworkNames(from command: String) -> [String] {
        execute(command)
            .split(separator: "\n")
            .compactMap { $0.split(separator: "/").last?.dropLast(2) }
            .map { String($0) }
    }

    @discardableResult
    private func execute(_ command: String) -> String {
        let task = Process()
        let pipe = Pipe()

        task.standardOutput = pipe
        task.standardError = pipe
        task.arguments = ["-c", command]
        task.launchPath = "/bin/zsh"
        task.launch()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)!

        return output
    }
}

private extension CreateXCFramework {

    /// Method generates URL path by given absolute path and needed location
    func generateUrl(for rootPath: String, with source: String) -> String {
        var pathComponents = rootPath.components(separatedBy: "/").filter { $0 != "" }
        pathComponents.removeSubrange(pathComponents.count - 2...pathComponents.count - 1)
        return "/" + pathComponents.joined(separator: "/") + "/" + source
    }

}
