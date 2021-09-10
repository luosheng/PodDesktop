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
            self.startWatchingEvents()
        }
    }
    
    private func startWatchingEvents() {
        ShellService.instance.runWithIntermediateOutput("/bin/bash", ["-l", "-c", "lima nerdctl events"]) { output in
            let events = try? output.split(separator: "\n")
                .map { String($0) }
                .filter { $0.trimmingCharacters(in: .whitespacesAndNewlines) != "" }
                .map(Event.parse(output:))
            events?.forEach { event in
                self.listeners.forEach { $0(event) }
            }
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
    
    func fetchImages(completion: @escaping ([OCIImage]) -> Void) {
        runCommand(["images", "--format", "{{json}}"]) {json in
            completion(decode([OCIImage].self, from: json))
        }
    }
    
    func restartContainer(container: Container) {
        runCommand(["stop", container.id]) { _ in
            self.runCommand(["start", container.id])
        }
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
