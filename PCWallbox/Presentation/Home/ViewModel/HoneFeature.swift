//
//  HomeFeature.swift
//  PCWallbox
//
//  Created by Luis Cañadas Treceño on 6/3/22.
//

import Foundation
import Combine

protocol HomeViewModelProtocol {
    var text: CurrentValueSubject<String, Never> { get set }
    var translated: CurrentValueSubject<String, Never> { get set }

    func viewDidLoad()
}

protocol HomeNavigatorProtocol {}
