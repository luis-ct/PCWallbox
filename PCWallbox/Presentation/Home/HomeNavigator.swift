//
//  HomeNavigator.swift
//  PCWallbox
//
//  Created by Luis Cañadas Treceño on 6/3/22.
//

import UIKit

class HomeNavigator: HomeNavigatorProtocol {
    weak var view: HomeViewController?
    weak var navigationController: UINavigationController?

    func start() {
        guard let view = view else { return }
        navigationController?.setViewControllers([view], animated: false)
    }
}
