//
//  PodmanService.swift
//  PodmanDesktop
//
//  Created by Luo Sheng on 2021/9/7.
//

import Foundation

final class PodmanService {
    
    typealias EventListener = (Event) -> Void
    
    private var podmanPath = "/usr/local/bin/podman"
    private var listeners: [EventListener] = []
    
    static let instance = PodmanService()
    
    private func runCommand(_ args: String..., completion: ((String?) -> Void)?) {
        shell(podmanPath, args, completion)
    }
    
    private func runCommand(_ args: String...) {
        shell(podmanPath, args)
    }
    
    init() {
        shell("/bin/bash", ["-l", "-c", "which podman"]) { path in
            guard let path = path else {
                return
            }
            self.podmanPath = path
            
            interactiveShell(self.podmanPath, ["events", "--format", "{{json}}"]) { output in
                let events = output.split(separator: "\n")
                    .map { $0.data(using: .utf8) }
                    .filter { $0 != .none }
                    .map { decode(Event.self, from: $0!) }
                events.forEach { event in
                    self.listeners.forEach { listener in
                        listener(event)
                    }
                }
                
            }
        }
    }
    
    func addEventListener(_ listener: @escaping EventListener) {
        listeners.append(listener)
    }
    
    func fetchContainers(completion: @escaping ([Container]) -> Void) {
        runCommand("ps", "-a", "--format", "{{json}}") { json in
            guard let json = json else {
                completion([])
                return
            }
            completion(decode([Container].self, from: json))
        }
    }
    
    func fetchImages(completion: @escaping ([PodmanImage]) -> Void) {
        runCommand("images", "--format", "{{json}}") { json in
            guard let json = json else {
                completion([])
                return
            }
            completion(decode([PodmanImage].self, from: json))
        }
    }
    
    func restartContainer(container: Container) {
        runCommand("restart", container.id)
    }
    
    func stopContainer(container: Container) {
        runCommand("stop", container.id)
    }
    
    func startContainer(container: Container) {
        runCommand("restart", container.id)
    }
    
    func removeContainer(container: Container) {
        runCommand("rm", container.id)
    }
}
