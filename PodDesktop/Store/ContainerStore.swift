//
//  ContainerStore.swift
//  PodDesktop
//
//  Created by Luo Sheng on 2021/9/7.
//

import Foundation

final class ContainerStore: ObservableObject {
    
    @Published var containers: [Container] = []
    
    init() {
        PodService.instance.addEventListener { event in
            print(event)
            self.fetch()
        }
    }
    
    func fetch() {
        PodService.instance.fetchContainers { containers in
            DispatchQueue.main.async {
                self.containers = containers
            }
        }
    }
    
}
