//
//  ContainerView.swift
//  PodmanDesktop
//
//  Created by Luo Sheng on 2021/9/7.
//

import SwiftUI

struct ContainerView: View {
    @ObservedObject var containerStore: ContainerStore
    
    var body: some View {
        List() {
            ForEach(containerStore.containers) { container in
                Text(container.names.joined(separator: ", "))
            }
        }.onAppear(perform: {
            containerStore.fetch()
        })
    }
 }

struct ContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ContainerView(containerStore: MockModel().containerStore)
    }
}
