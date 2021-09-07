//
//  ContainerItem.swift
//  PodmanDesktop
//
//  Created by Luo Sheng on 2021/9/7.
//

import SwiftUI

struct ContainerItem: View {
    
    var container: Container
    
    var body: some View {
        HStack{
            VStack {
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
                    Text(formatPorts(ports: container.ports))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
            HStack {
                Button("Stop") {
                    
                }
            }
            .padding(.trailing, 10)
        }
        
    }
    
    private func formatPorts(ports: [Container.Port]) -> String {
        return ports.map {
            formatPort(port: $0)
        }.joined(separator: " ")
    }
    
    private func formatPort(port: Container.Port) -> String {
        if let hostPort = port.hostPort {
            var hostIp = port.hostIP
            if (hostIp == "") {
                hostIp = "0.0.0.0"
            }
            return "\(hostIp):\(hostPort)->\(port.containerPort)"
        } else {
            return "\(port.containerPort)"
        }
    }
}

struct ContainerItem_Previews: PreviewProvider {
    static var previews: some View {
        ContainerItem(container: MockModel().containerStore.containers[0])
    }
}
