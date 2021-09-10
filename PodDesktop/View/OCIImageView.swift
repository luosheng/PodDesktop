//
//  ImageView.swift
//  PodDesktop
//
//  Created by Luo Sheng on 2021/9/7.
//

import SwiftUI

struct OCIImageView: View {
    
    @ObservedObject var imageStore: ImageStore
    @State var imageToPull: String = ""
    @State var imageToBuild: String = ""
    
    var body: some View {
        NavigationView {
            List() {
                ForEach(imageStore.images) { image in
                    OCIImageItem(image: image)
                }
            }
            .frame(minWidth: 500, maxWidth: .infinity)
            
            OCIImageOperationView()
                .frame(minWidth: 300, idealWidth: 300, maxWidth: 300)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear(perform: {
            imageStore.fetch()
        })
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        OCIImageView(imageStore: MockModel().imageStore)
    }
}
