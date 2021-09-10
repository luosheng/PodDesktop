//
//  Event.swift
//  PodmanDesktop
//
//  Created by Luo Sheng on 2021/9/7.
//

import Foundation

struct Event: Codable {
    var containerId: String?
    var processId: Int32?
    var type: String!
    
    enum CodingKeys: String, CodingKey {
        case containerId = "container_id"
        case processId = "pid"
    }
    
    static func parse(output: String) throws -> Event {
        let pattern = #"(?<type>\/\S*)\s*(?<json>\{.*\})"#
        let regex = try NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(output.startIndex..<output.endIndex, in: output)
        guard let match = regex.firstMatch(in: output, options: [], range: range) else {
            fatalError("Can not decode event log")
        }
        
        guard let typeRange = Range(match.range(withName: "type"), in: output),
              let jsonRange = Range(match.range(withName: "json"), in: output) else {
            fatalError("Can not decode event log")
        }
        let type = output[typeRange]
        let json = output[jsonRange]
        
        var event = decode(Event.self, from: String(json))
        event.type = String(type)
        
        return event
    }
}
