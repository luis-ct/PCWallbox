//
//  RepositoriesLocator.swift
//  PCWallbox
//
//  Created by Luis Cañadas Treceño on 9/3/22.
//

import Foundation

struct RepositoriesLocator {
    func makeCharactersRepository() -> TranslatorRepository {
        return TranslatorRepository(api: ApiClientFake(), local: TranslatorLocal())
    }
}
