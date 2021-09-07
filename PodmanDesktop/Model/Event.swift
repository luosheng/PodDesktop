//
//  Event.swift
//  PodmanDesktop
//
//  Created by Luo Sheng on 2021/9/7.
//

import Foundation

struct Event: Codable {
    var name: String
    var status: String
    var time: String
    var type: String
    var attributes: [String:String]
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case status = "Status"
        case time = "Time"
        case type = "Type"
        case attributes = "Attributes"
    }
}
