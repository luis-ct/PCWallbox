//
//  StateViewModel.swift
//  PCWallbox
//
//  Created by Luis Cañadas Treceño on 9/3/22.
//

import Foundation

enum StateViewModel<O> {
    case initial
    case loading
    case success(O)
    case failure(Error)
}
