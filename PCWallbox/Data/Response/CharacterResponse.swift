//
//  CharacterResponse.swift
//  PCWallbox
//
//  Created by Luis Cañadas Treceño on 10/3/22.
//

import Foundation

struct CharacterResponse: Codable {
    let results: [Character]

    enum CodingKeys: String, CodingKey {
      case data
    }

    enum DataCodingKeys: String, CodingKey {
        case results
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container( keyedBy: CodingKeys.self)
        var data = container.nestedContainer(keyedBy: DataCodingKeys.self, forKey: .data)
        try data.encode(results, forKey: .results)
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.nestedContainer(keyedBy: DataCodingKeys.self, forKey: .data)
        self.results = try data.decode([Character].self, forKey: .results)
    }
}
