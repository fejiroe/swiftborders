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

if execute("swift build -c release") {
    // if shell("cp ./.build/NAMEOFEXECUTABLE /usr/local/bin/NAMEOFEXECUTABLE") {
    // copy the executable to /usr/local/bin or whatever
    //   if shell("cp ./LaunchAgents/ ///") {
    //      // copy launch agent plist
    //     }
    // } 
}
