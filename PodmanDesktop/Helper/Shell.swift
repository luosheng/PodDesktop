//
//  Shell.swift
//  PodmanDesktop
//
//  Created by Luo Sheng on 2021/9/7.
//

import Foundation

func shell(_ launchPath: String, _ arguments: [String]) -> String? {
    let task = Process()
    task.launchPath = launchPath
    task.arguments = arguments
    
    let pipe = Pipe()
    task.standardOutput = pipe
    task.launch()
    
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines)
    return output
}

func interactiveShell(_ launchPath: String, _ arguments: [String], progress: @escaping (String) -> Void) {
    let task = Process()
    task.launchPath = launchPath
    task.arguments = arguments
    
    let pipe = Pipe()
    task.standardOutput = pipe
    
    pipe.fileHandleForReading.readabilityHandler = { (fileHandle) -> Void in
        let availableData = fileHandle.availableData
        if let newOutput = String(data: availableData, encoding: .utf8) {
            progress(newOutput)
        }
    }
    
    task.launch()
    task.waitUntilExit()
}
