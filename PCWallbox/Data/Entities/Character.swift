//
//  Character.swift
//  PCWallbox
//
//  Created by Luis Cañadas Treceño on 6/3/22.
//

import Foundation

struct Character: Codable {
    let id: String
    let name, description: String
    let thumbnail: Thumbnail

    var thumbnailUrl: String {
        "\(thumbnail.path).\(thumbnail.thumbnailExtension)"
    }

    enum CodingKeys: String, CodingKey {
        case id, name
        case description
        case thumbnail
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let value = try container.decode(Int.self, forKey: .id)
        self.id = "\(value)"
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(String.self, forKey: .description)
        self.thumbnail = try container.decode(Thumbnail.self, forKey: .thumbnail)
    }
}

struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}
