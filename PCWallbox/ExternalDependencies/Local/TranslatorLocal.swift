//
//  TranslatorLocal.swift
//  PCWallbox
//
//  Created by Luis Cañadas on 10/7/22.
//

import Foundation

class TranslatorLocal: TranslatorRepositoryLocalProtocol {
    let defaults = UserDefaults.standard

    private let key = "TranslationKey"

    var translation: String {
        get {
            return defaults.string(forKey: key) ?? ""
        }
        set {
            defaults.set(newValue, forKey: key)
        }
    }
}
