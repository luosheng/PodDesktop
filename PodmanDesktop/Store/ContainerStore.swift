//
//  ContainerStore.swift
//  PodmanDesktop
//
//  Created by Luo Sheng on 2021/9/7.
//

import Foundation

final class ContainerStore: ObservableObject {
    
    @Published var containers: [Container] = []
    
    func fetch() {
        guard let json = shell("/usr/local/bin/podman", ["ps", "-a", "--format", "{{json}}"]) else {
            return
        }
        guard let data = json.data(using: .utf8) else {
            return
        }
        let decoder = JSONDecoder()
        do {
            containers = try decoder.decode([Container].self, from: data)
        } catch {
            
        }
    }
    
}
