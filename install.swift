/*
 install script,
 build exec,
 copy exec to local/bin
 install launch agent? (copy plist)
*/
import Foundation

let fm = FileManager.default
let dir = fm.currentDirectoryPath

func execute(_ command: String) {
    let task = Process()
    let pipe = Pipe()
    let inPipe = Pipe()
    task.arguments = ["-c", command]
    task.launchPath = "/bin/zsh"
    task.standardOutput = pipe
    task.standardError = pipe
    do {
        try task.run()
        task.waitUntilExit()
        let outb = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(bytes: outb, encoding: .utf8)
        if output != nil {
            print(output as Any)
        }
        let filehandle = FileHandle(fileDescriptor: STDIN_FILENO)
        filehandle.readabilityHandler = { handle in
            let inData = handle.availableData
            if inData.count > 0 {
                inPipe.fileHandleForWriting.write(inData)
                if output != nil {
                print(output as Any)
        }
            }
        }
    } catch {
        print("cmd failed")
    }
}

execute("swift build -c release -Xswiftc -cross-module-optimization")
    // if let path = execute("swit bulid --show-bin-path -c release") { // get full path of release build
execute("sudo cp .build/release/swiftborders /usr/local/bin/swiftborders") // dont take password in plain text please looooool
print("install success")
            // if shell("cp ./LaunchAgents/ ///") {
    //      // copy launch agent plist
    //     }
    // }
/* just found this, will reference some ideas for the install
https://github.com/yonaskolb/Mint/blob/master/Sources/MintKit/Mint.swift
*/
