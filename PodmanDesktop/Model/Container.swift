//
//  Container.swift
//  PodmanDesktop
//
//  Created by Luo Sheng on 2021/9/7.
//

import Foundation

struct Container: Codable, Identifiable {
    
    struct Port: Codable {
        var hostPort: Int
        var containerPort: Int
        var `protocol`: String
        var hostIP: String
    }
    
    var autoRemove: Bool
    var command: [String]
    var createdAt: String
    var exited: Bool
    var exitedAt: Int
    var exitCode: Int
    var id: String
    var image: String
    var imageId: String
    var isInfra: Bool
    var labels: [String]?
    var mounts: [String]?
    var names: [String]
    var networks: [String]
    var pid: Int
    var pod: String
    var podName: String
    var ports: [Port]?
    var size: Int?
    var startedAt: Int
    var state: String
    var status: String
    var created: Int
    
    enum CodingKeys: String, CodingKey {
        case autoRemove = "AutoRemove"
        case command = "Command"
        case createdAt = "CreatedAt"
        case exited = "Exited"
        case exitedAt = "ExitedAt"
        case exitCode = "ExitCode"
        case id = "Id"
        case image = "Image"
        case imageId = "ImageID"
        case isInfra = "IsInfra"
        case labels = "Labels"
        case mounts = "Mounts"
        case names = "Names"
        case networks = "Networks"
        case pid = "Pid"
        case pod = "Pod"
        case podName = "PodName"
        case ports = "Ports"
        case size = "Size"
        case startedAt = "StartedAt"
        case state = "State"
        case status = "Status"
        case created = "Created"
    }
}
