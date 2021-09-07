//
//  Image.swift
//  PodmanDesktop
//
//  Created by Luo Sheng on 2021/9/7.
//

import Foundation

struct Image: Decodable, Identifiable {
    var id: String
    var parentId: String
    var repoTags: [String]?
    var repoDigests: [String]
    var size: Int
    var sharedSize: Int
    var virtualSize: Int32
    var labels: [String:String]?
    var containers: Int
    var names: [String]
    var digest: String
    var history: [String]
    var created: Int32
    var createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case parentId = "ParentId"
        case repoTags = "RepoTags"
        case repoDigests = "RepoDigests"
        case size = "Size"
        case sharedSize = "SharedSize"
        case virtualSize = "VirtualSize"
        case labels = "Labels"
        case containers = "Containers"
        case names = "Names"
        case digest = "Digest"
        case history = "History"
        case created = "Created"
        case createdAt = "CreatedAt"
    }
}
