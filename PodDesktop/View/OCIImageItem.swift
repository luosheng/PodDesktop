//
//  OCIImageItem.swift
//  PodDesktop
//
//  Created by Luo Sheng on 2021/9/10.
//

import SwiftUI

struct OCIImageItem: View {
    
    var image: OCIImage
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(image.repository + ":" + image.tag)
                    .font(.headline)
                Text(image.id)
            }
            HStack {
                Text(image.createdSince)
                Text(image.size)
            }
        }
    }
}

struct OCIImageItem_Previews: PreviewProvider {
    static var previews: some View {
        OCIImageItem(image: MockModel().imageStore.images[0])
    }
}
