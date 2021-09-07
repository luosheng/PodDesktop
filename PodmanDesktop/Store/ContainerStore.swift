//
//  ContainerStore.swift
//  PodmanDesktop
//
//  Created by Luo Sheng on 2021/9/7.
//

import Foundation

final class ContainerStore: ObservableObject {
    
    @Published var containers: [Container] = []
    
    init() {
        PodmanService.instance.addEventListener { event in
            self.fetch()
        }
    }
    
    func fetch() {
        if let containers = PodmanService.instance.fetchContainers() {
            self.containers = containers
        }
    }
    
}
