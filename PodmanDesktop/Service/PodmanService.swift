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
    
    func fetchContainers(completion: @escaping ([Container]?) -> Void) {
        shell(podmanPath, ["ps", "-a", "--format", "{{json}}"]) { json in
            guard let json = json else {
                completion(.none)
                return
            }
            guard let data = json.data(using: .utf8) else {
                completion(.none)
                return
            }
            let decoder = JSONDecoder()
            completion(try? decoder.decode([Container].self, from: data))
        }
    }
}
