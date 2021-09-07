//
//  MockModel.swift
//  PodmanDesktop
//
//  Created by Luo Sheng on 2021/9/7.
//

import Foundation

final class MockModel {
    
    @Published var containerStore: ContainerStore
    
    init() {
        containerStore = ContainerStore()
        containerStore.containers = loadMock("containers.json")
    }
}
