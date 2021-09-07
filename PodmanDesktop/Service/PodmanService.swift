//
//  PodmanService.swift
//  PodmanDesktop
//
//  Created by Luo Sheng on 2021/9/7.
//

import Foundation

struct PodmanService {
    private var podmanPath = "/usr/local/bin/podman"
    
    static func fetchContainers() -> [Container]? {
        guard let json = shell("/usr/local/bin/podman", ["ps", "-a", "--format", "{{json}}"]) else {
            return .none
        }
        guard let data = json.data(using: .utf8) else {
            return .none
        }
        let decoder = JSONDecoder()
        return try? decoder.decode([Container].self, from: data)
    }
}
