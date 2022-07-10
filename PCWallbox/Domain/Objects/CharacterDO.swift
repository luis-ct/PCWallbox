//
//  CharacterDO.swift
//  PCWallbox
//
//  Created by Luis Cañadas Treceño on 6/3/22.
//

import Foundation

class CharacterDO {
    let id: String
    let image: String
    let name: String

    init(
        id: String,
        image: String,
        name: String
    ) {
        self.id = id
        self.image = image
        self.name = name
    }
}
