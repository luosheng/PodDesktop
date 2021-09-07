//
//  Sidebar.swift
//  PodmanDesktop
//
//  Created by Luo Sheng on 2021/9/7.
//

import SwiftUI

struct Sidebar: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: ContainerView(containerStore: ContainerStore())) {
                    Text("Containers / Apps")
                }
            }
            .listStyle(SidebarListStyle())
        }
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar()
    }
}
