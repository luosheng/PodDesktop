//
//  MockModel.swift
//  PodDesktop
//
//  Created by Luo Sheng on 2021/9/7.
//

import Foundation

final class MockModel {
    
    @Published private(set) var containerStore: ContainerStore!
    @Published private(set) var imageStore: ImageStore!
    
    init() {
        containerStore = ContainerStore()
        containerStore.containers = [loadMock("containers.json")]
        
        imageStore = ImageStore()
        imageStore.images = [loadMock("images.json")]
    }
}
