//
//  Sidebar.swift
//  PodmanDesktop
//
//  Created by Luo Sheng on 2021/9/7.
//

import SwiftUI
import SFSafeSymbols

struct Sidebar: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: ContainerView(containerStore: ContainerStore())) {
                    Text("Containers")
                        .font(.title2)
                }
            }
            .listStyle(SidebarListStyle())
        }
        .toolbar {
            ToolbarItem(placement: .status) {
                Button(action: {}) {
                    Image(systemSymbol: .sidebarLeading)
                }
            }
        }
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar()
    }
}
