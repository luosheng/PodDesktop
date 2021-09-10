//
//  Image.swift
//  PodDesktop
//
//  Created by Luo Sheng on 2021/9/7.
//

import Foundation

struct OCIImage: Decodable, Identifiable {
    var id: String
    var repository: String
    var tag: String
    var size: String
    var createdSince: String
    var createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case repository = "Repository"
        case tag = "Tag"
        case size = "Size"
        case createdSince = "CreatedSince"
        case createdAt = "CreatedAt"
    }
    
    static func parse(output: String) -> [OCIImage] {
        return output.split(separator: "\n")
            .filter { $0.starts(with: "{") }
            .map { decode(OCIImage.self, from: String($0)) }
    }
    
    var repositoryWithTag: String {
        return "\(repository == "" ? "<none>" : repository):\(tag == "" ? "<none>" : tag)"
    }
}
