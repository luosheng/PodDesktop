//
//  ContainerItem.swift
//  PodmanDesktop
//
//  Created by Luo Sheng on 2021/9/7.
//

import SwiftUI
import SFSafeSymbols

struct ContainerItem: View {
    
    var container: Container
    @State private var hovering = false
    
    var isRunning: Bool {
        container.state == "running"
    }
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemSymbol: .shippingboxFill)
                .resizable()
                .frame(width: 32, height: 32)
                .foregroundColor(isRunning ? .accentColor : .gray)
            VStack(alignment: .leading) {
                HStack {
                    Text(container.names.joined(separator: ","))
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text(container.image)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text(container.status)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(container.readablePorts)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
            HStack {
                Button("Stop") {
                    
                }
            }
            .opacity(hovering ? 1 : 0)
            .padding(.trailing, 10)
        }
        .onHover(perform: { hovering in
            self.hovering = hovering
        })
        
    }
}

struct ContainerItem_Previews: PreviewProvider {
    static var previews: some View {
        ContainerItem(container: MockModel().containerStore.containers[0])
    }
}
