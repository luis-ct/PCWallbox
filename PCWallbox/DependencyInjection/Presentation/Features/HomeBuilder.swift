//
//  HomeBuilder.swift
//  PCWallbox
//
//  Created by Luis Cañadas Treceño on 6/3/22.
//

import Foundation

struct HomeBuilder {
    func build() -> (HomeViewController, HomeNavigator) {
        let useCase = UseCasesLocator().makeListUseCase()
        let view = HomeViewController()
        let viewModel = HomeViewModel(useCase: useCase)
        let navigator = HomeNavigator()

        view.viewModel = viewModel

        viewModel.navigator = navigator

        navigator.view = view
        return (view, navigator)
    }
}
