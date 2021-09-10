//
//  Shell.swift
//  PodDesktop
//
//  Created by Luo Sheng on 2021/9/7.
//

import Foundation

func shell(_ launchPath: String, _ arguments: [String]) {
    shell(launchPath, arguments, nil)
}

func shell(_ launchPath: String, _ arguments: [String], _ completionHandler: ((String?) -> Void)?) {
    DispatchQueue.global().async {
        let task = Process()
        task.launchPath = launchPath
        task.arguments = arguments
        
        let pipe = Pipe()
        task.standardOutput = pipe
        task.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let completionHandler = completionHandler else {
            return
        }
        completionHandler(output)
    }
}

func interactiveShell(_ launchPath: String, _ arguments: [String]) {
    interactiveShell(launchPath, arguments, nil)
}

func interactiveShell(_ launchPath: String, _ arguments: [String], _ progressHandler: ((String) -> Void)?) {
    DispatchQueue.global().async {
        let task = Process()
        task.launchPath = launchPath
        task.arguments = arguments
        
        let pipe = Pipe()
        task.standardOutput = pipe
        
        pipe.fileHandleForReading.readabilityHandler = { (fileHandle) -> Void in
            let availableData = fileHandle.availableData
            guard let newOutput = String(data: availableData, encoding: .utf8),
               let progressHandler = progressHandler else {
                return
            }
            progressHandler(newOutput)
        }
        
        task.launch()
        task.waitUntilExit()
    }
}
