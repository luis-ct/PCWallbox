//
//  HomeFeature.swift
//  PCWallbox
//
//  Created by Luis Cañadas Treceño on 6/3/22.
//

import Foundation
import Combine

protocol HomeViewModelProtocol {
    var item: HomeItem { get set }
    func viewDidLoad()
}

protocol HomeNavigatorProtocol {}
