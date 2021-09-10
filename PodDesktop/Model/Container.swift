//
//  Container.swift
//  PodDesktop
//
//  Created by Luo Sheng on 2021/9/7.
//

import Foundation

struct Container: Codable, Identifiable {
    
    var command: String
    var createdAt: String
    var id: String
    var image: String
    var names: String
    var ports: String
    var status: String
    
    enum CodingKeys: String, CodingKey {
        case command = "Command"
        case createdAt = "CreatedAt"
        case id = "ID"
        case image = "Image"
        case names = "Names"
        case ports = "Ports"
        case status = "Status"
    }
    
    static func parse(output: String) -> [Container] {
        let lines = output.split(separator: "\n")
        let containers = lines.map { line in
            return decode(Container.self, from: String(line))
        }
        return containers
    }
}
