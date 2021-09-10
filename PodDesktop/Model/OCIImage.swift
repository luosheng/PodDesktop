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
}
