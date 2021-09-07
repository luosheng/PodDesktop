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
            print(event)
            self.fetch()
        }
    }
    
    func fetch() {
        PodmanService.instance.fetchContainers { containers in
            DispatchQueue.main.async {
                self.containers = containers
            }
        }
    }
    
}
