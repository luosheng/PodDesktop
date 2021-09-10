//
//  ShellService.swift
//  PodmanDesktop
//
//  Created by Luo Sheng on 2021/9/10.
//

import Foundation

final class ShellService {
    
    typealias OutputHandler = (String) -> Void
    
    var environment: [String: String] = [:]
    
    static let instance = ShellService()
    
    init() {
        let output = run("/bin/bash", ["-l", "-c", "printenv"])
        self.environment = self.parseEnvironment(output)
    }
    
    func run(_ launchPath: String, _ arguments: [String], _ completionHandler: OutputHandler?) {
        DispatchQueue.global().async {
            let task = Process()
            task.launchPath = launchPath
            task.arguments = arguments
            task.environment = self.environment
            
            let pipe = Pipe()
            task.standardOutput = pipe
            task.launch()
            
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            let output = String(data: data, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines)
            guard let completionHandler = completionHandler,
                  let output = output else {
                return
            }
            completionHandler(output)
        }
    }
    
    func runWithIntermediateOutput(_ launchPath: String, _ arguments: [String], _ intermediateOuptputHandler: OutputHandler?) {
        DispatchQueue.global().async {
            let task = Process()
            task.launchPath = launchPath
            task.arguments = arguments
            
            let pipe = Pipe()
            task.standardOutput = pipe
            
            pipe.fileHandleForReading.readabilityHandler = { (fileHandle) -> Void in
                let availableData = fileHandle.availableData
                guard let newOutput = String(data: availableData, encoding: .utf8),
                   let intermediateOuptputHandler = intermediateOuptputHandler else {
                    return
                }
                intermediateOuptputHandler(newOutput)
            }
            
            task.launch()
            task.waitUntilExit()
        }
    }
    
    private func run(_ launchPath: String, _ arguments: [String]) -> String {
        let task = Process()
        task.launchPath = launchPath
        task.arguments = arguments
        task.environment = self.environment
        
        let pipe = Pipe()
        task.standardOutput = pipe
        task.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines)
        return output ?? ""
    }
    
    private func parseEnvironment(_ output: String) -> [String: String] {
        var environment = Dictionary(uniqueKeysWithValues: output
                                        .split(separator: "\n")
                                        .map { $0.split(separator: "=") }
                                        .map { (String($0[0]), String($0[1])) })
        environment["HOME"] = FileManager.default.homeDirectoryForCurrentUser.path
        environment["TMPDIR"] = FileManager.default.temporaryDirectory.path
        environment["USER"] = NSUserName()
        return environment
    }
    
}
