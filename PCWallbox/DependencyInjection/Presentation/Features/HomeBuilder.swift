//
//  HomeBuilder.swift
//  PCWallbox
//
//  Created by Luis Cañadas Treceño on 6/3/22.
//

import Foundation

struct HomeBuilder {
    func build() -> (HomeViewController, HomeNavigator) {
        let view = HomeViewController()
        let abstractFactory = HomeViewModelAbstractFactoryImpl(useCasesLocator: UseCasesLocator())
        let viewModel = HomeViewModel(abstractFactory: abstractFactory)
        let navigator = HomeNavigator()

        view.viewModel = viewModel

        viewModel.navigator = navigator

        navigator.view = view
        return (view, navigator)
    }
}
