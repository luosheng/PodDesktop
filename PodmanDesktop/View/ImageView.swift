//
//  ImageView.swift
//  PodmanDesktop
//
//  Created by Luo Sheng on 2021/9/7.
//

import SwiftUI

struct ImageView: View {
    
    @ObservedObject var imageStore: ImageStore
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(imageStore: MockModel().imageStore)
    }
}
