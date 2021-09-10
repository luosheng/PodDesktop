//
//  PodmanService.swift
//  PodmanDesktop
//
//  Created by Luo Sheng on 2021/9/7.
//

import Foundation

final class PodService {
    
    typealias EventListener = (Event) -> Void
    
    private var limaPath = "/usr/local/bin/lima"
    private var listeners: [EventListener] = []
    
    static let instance = PodService()
    
    private func runCommand(_ args: [String], completion: ((String) -> Void)?) {
        ShellService.instance.run("/bin/bash", ["-l", "-c", (["lima", "nerdctl"] + args).joined(separator: " ")], completion)
    }
    
    private func runCommand(_ args: [String]) {
        runCommand(args, completion: nil)
    }
    
    init() {
        shell("/bin/zsh", ["-l", "-c", "which lima"]) { path in
            guard let path = path else {
                return
            }
            self.limaPath = path
            
//            interactiveShell(self.podmanPath, ["events", "--format", "{{json}}"]) { output in
//                let events = output.split(separator: "\n")
//                    .map { $0.data(using: .utf8) }
//                    .filter { $0 != .none }
//                    .map { decode(Event.self, from: $0!) }
//                events.forEach { event in
//                    self.listeners.forEach { listener in
//                        listener(event)
//                    }
//                }
//
//            }
        }
    }
    
    func addEventListener(_ listener: @escaping EventListener) {
        listeners.append(listener)
    }
    
    func fetchContainers(completion: @escaping ([Container]) -> Void) {
        runCommand(["ps", "-a", "--format", "'{{json .}}'"]) { output in
            completion(Container.parse(output: output))
        }
    }
    
    func fetchImages(completion: @escaping ([PodmanImage]) -> Void) {
        runCommand(["images", "--format", "{{json}}"]) {json in
            completion(decode([PodmanImage].self, from: json))
        }
    }
    
    func restartContainer(container: Container) {
        runCommand(["restart", container.id])
    }
    
    func stopContainer(container: Container) {
        runCommand(["stop", container.id])
    }
    
    func startContainer(container: Container) {
        runCommand(["start", container.id])
    }
    
    func removeContainer(container: Container) {
        runCommand(["rm", container.id])
    }
}
