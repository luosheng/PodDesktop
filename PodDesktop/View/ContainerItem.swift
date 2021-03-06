//
//  ContainerItem.swift
//  PodDesktop
//
//  Created by Luo Sheng on 2021/9/7.
//

import SwiftUI
import SFSafeSymbols

struct ContainerItem: View {
    
    var container: Container
    @State private var hovering = false
    
    var isRunning: Bool {
        container.status == "Up"
    }
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemSymbol: .shippingboxFill)
                .resizable()
                .frame(width: 32, height: 32)
                .foregroundColor(isRunning ? .accentColor : .gray)
            VStack(alignment: .leading) {
                HStack {
                    Text(container.names)
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
                    Text(container.ports)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
            HStack {
                Button(action: {
                    PodService.instance.restartContainer(container: container)
                }) {
                    Image(systemSymbol: .arrowClockwiseCircle)
                        .resizable()
                        .foregroundColor(.accentColor)
                }
                .disabled(!isRunning)
                .buttonStyle(PlainButtonStyle())
                .frame(width: 24, height: 24)
                
                if (isRunning) {
                    Button(action: {
                        PodService.instance.stopContainer(container: container)
                    }) {
                        Image(systemSymbol: .stopCircle)
                            .resizable()
                            .foregroundColor(.accentColor)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: 24, height: 24)
                } else {
                    Button(action: {
                        PodService.instance.startContainer(container: container)
                    }) {
                        Image(systemSymbol: .playCircle)
                            .resizable()
                            .foregroundColor(.accentColor)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: 24, height: 24)
                }
                
                Button(action: {
                    PodService.instance.removeContainer(container: container)
                }) {
                    Image(systemSymbol: .trashCircle)
                        .resizable()
                        .foregroundColor(.accentColor)
                }
                .buttonStyle(PlainButtonStyle())
                .frame(width: 24, height: 24)
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
