import Foundation

let fm = FileManager.default
let cwd = fm.currentDirectoryPath

@discardableResult
func run(_ launchPath: String, arguments: [String]) -> (output: String?, exitCode: Int32) {
    let task = Process()
    task.launchPath = launchPath
    task.arguments = arguments

    let pipe = Pipe()
    task.standardOutput = pipe
    task.standardError = pipe

    do {
        try task.run()
    } catch {
        return (nil, 1)
    }

    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    task.waitUntilExit()

    return (String(data: data, encoding: .utf8), task.terminationStatus)
}

// build
print("building in release mode…")
let build = run("/usr/bin/swift", arguments: ["build", "-c", "release"])
guard build.exitCode == 0 else {
    print("❌ build failed:\n\(build.output ?? "")")
    exit(1)
}

// find the binary path
let showBin = run("/usr/bin/swift", arguments: ["build", "--show-bin-path", "-c", "release"])
guard let binDir = showBin.output?.trimmingCharacters(in: .whitespacesAndNewlines),
    !binDir.isEmpty
else {
    print("❌ couldn't find the build output directory.")
    exit(1)
}
let binaryPath = "\(binDir)/swiftborders"
print("✅ binary built at: \(binaryPath)")

/* // this fails, permissions? says cp can't open source
// copy to /usr/local/bin
print("copying binary to /usr/local/bin…")
let copy = run("/bin/zsh", arguments: ["cp", binaryPath, "/usr/local/bin/swiftborders"])
guard copy.exitCode == 0 else {
    print("❌ copy failed:\n\(copy.output ?? "")")
    exit(1)
}
print("✅ copied successfully.")
*/

// bootstrap the LaunchAgent
print("enabling launch agent…")
let enable = run(
    "/bin/launchctl",
    arguments: [
        "enable", "gui/\(getuid())",
    ])
guard enable.exitCode == 0 else {
    print("❌ launchAgent enable failed:\n\(enable.output ?? "")")
    exit(1)
}
let bootstrap = run(  // seems to always fail with code 5, input/output error
    "/bin/launchctl",
    arguments: [
        "bootstrap", "gui/\(getuid())",
        "\(NSHomeDirectory())/Library/LaunchAgents/com.fejiroe.swiftborders.plist",
    ])
guard bootstrap.exitCode == 0 else {
    print("❌ launchAgent bootstrap failed:\n\(bootstrap.output ?? "")")
    exit(1)
}
print("✅ launchAgent loaded. show with:")
print("\tlaunchctl list | grep com.fejiroe.swiftborders")
// unload launch agent
// let bootout = run("/bin/launchctl", arguments: ["bootout", "gui/\(getuid())",
//                                                 "\(NSHomeDirectory())/Library/LaunchAgents/com.fejiroe.swiftborders.plist"])
