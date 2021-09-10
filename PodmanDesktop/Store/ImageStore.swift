//
//  ImageStore.swift
//  PodmanDesktop
//
//  Created by Luo Sheng on 2021/9/7.
//

import Foundation

final class ImageStore: ObservableObject {
    
    @Published var images: [OCIImage] = []
    
    init() {
        PodService.instance.addEventListener { event in
            self.fetch()
        }
    }
    
    func fetch() {
        PodService.instance.fetchImages { images in
            DispatchQueue.main.async {
                self.images = images
            }
        }
    }
    
}
