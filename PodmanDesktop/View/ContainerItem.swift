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
        VStack {
            HStack {
                Text(container.names.joined(separator: ","))
                Text(container.image)
            }
            HStack {
                Text(container.status)
                Text(formatPorts(ports: container.ports))
            }
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
