import Foundation

let launchAgentPath = "\(NSHomeDirectory())/Library/LaunchAgents/com.fejiroe.swiftborders.plist"

struct Cli {
    public func runLaunchCtl(_ command: String) {
        let task = Process()
        task.launchPath = "/bin/launchctl"
        task.arguments = [
            command,
            "gui/\(getuid())",
            launchAgentPath,
        ]

        task.standardOutput = Pipe()
        task.standardError = Pipe()

        do {
            try task.run()
            task.waitUntilExit()
            print("launchctl \(command) finished with exit code", task.terminationStatus)
        } catch {
            print("launchctl \(command) failed:", error)
        }
    }
}
