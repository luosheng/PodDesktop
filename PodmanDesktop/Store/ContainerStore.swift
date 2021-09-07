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
        if let containers = PodmanService.fetchContainers() {
            self.containers = containers
        }
    }
    
}
