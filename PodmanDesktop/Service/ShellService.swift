//
//  ShellService.swift
//  PodmanDesktop
//
//  Created by Luo Sheng on 2021/9/10.
//

import Foundation

final class ShellService {
    
    typealias CompletionHandler = (String) -> Void
    
    var environment: [String: String] = [:]
    
    static let instance = ShellService()
    
    init() {
        let output = run("/bin/bash", ["-l", "-c", "printenv"])
        self.environment = self.parseEnvironment(output)
    }
    
    func run(_ launchPath: String, _ arguments: [String], _ completion: CompletionHandler?) {
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
            guard let completion = completion,
                  let output = output else {
                return
            }
            completion(output)
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
