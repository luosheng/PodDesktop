//
//  ShellService.swift
//  PodmanDesktop
//
//  Created by Luo Sheng on 2021/9/10.
//

import Foundation

final class ShellService {
    
    typealias CompletionHandler = (String) -> Void
    
    private func _shell(_ launchPath: String, _ arguments: [String], _ completion: CompletionHandler?) {
        DispatchQueue.global().async {
            let task = Process()
            task.launchPath = launchPath
            task.arguments = arguments
            
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
    
}
