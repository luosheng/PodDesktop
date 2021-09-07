//
//  ImageStore.swift
//  PodmanDesktop
//
//  Created by Luo Sheng on 2021/9/7.
//

import Foundation

final class ImageStore: ObservableObject {
    
    @Published var images: [Image] = []
    
    init() {
        PodmanService.instance.addEventListener { event in
            self.fetch()
        }
    }
    
    func fetch() {
        PodmanService.instance.fetchImages { images in
            DispatchQueue.main.async {
                self.images = images
            }
        }
    }
    
}
