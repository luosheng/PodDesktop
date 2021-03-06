//
//  Sidebar.swift
//  PodDesktop
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
                    SidebarItem(title: "Containers")
                }
                NavigationLink(
                    destination: OCIImageView(imageStore: ImageStore())) {
                    SidebarItem(title: "Images")
                }
            }
            .listStyle(SidebarListStyle())
        }
        .toolbar {
            ToolbarItem(placement: .status) {
                Button(action: {
                    NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
                }) {
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
