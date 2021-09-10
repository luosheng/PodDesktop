//
//  SidebarItem.swift
//  PodDesktop
//
//  Created by Luo Sheng on 2021/9/10.
//

import SwiftUI

struct SidebarItem: View {
    var title: String
    
    var body: some View {
        Text(title)
            .font(.title3)
    }
}

struct SidebarItem_Previews: PreviewProvider {
    static var previews: some View {
        SidebarItem(title: "Sidebar")
    }
}
