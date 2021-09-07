//
//  PodmanService.swift
//  PodmanDesktop
//
//  Created by Luo Sheng on 2021/9/7.
//

import Foundation

struct PodmanService {
    
    typealias EventListener = (Event) -> Void
    
    private var podmanPath = "/usr/local/bin/podman"
    private var listeners: [EventListener] = []
    
    static let instance = PodmanService()
    
    init() {
        if let path = shell("/bin/bash", ["-l", "-c", "which podman"]) {
            podmanPath = path
        }
    }
    
    mutating func addEventListener(listener: @escaping EventListener) {
        listeners.append(listener)
    }
    
    func fetchContainers() -> [Container]? {
        guard let json = shell(podmanPath, ["ps", "-a", "--format", "{{json}}"]) else {
            return .none
        }
        guard let data = json.data(using: .utf8) else {
            return .none
        }
        let decoder = JSONDecoder()
        return try? decoder.decode([Container].self, from: data)
    }
}
