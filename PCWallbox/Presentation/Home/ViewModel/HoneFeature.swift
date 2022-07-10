//
//  HomeFeature.swift
//  PCWallbox
//
//  Created by Luis Cañadas Treceño on 6/3/22.
//

import Foundation
import Combine

protocol HomeViewModelProtocol {
    var characters: CurrentValueSubject<StateViewModel<[CharacterItem]>, Never> { get }
    func viewDidLoad()
    func selectCharacter(at index: Int)
}

protocol HomeNavigatorProtocol {}
