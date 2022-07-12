//
//  HomeViewController.swift
//  PCWallbox
//
//  Created by Luis Cañadas Treceño on 6/3/22.
//

import UIKit
import SwiftUI
import Combine

class HomeViewController: UIViewController {
    var viewModel: HomeViewModelProtocol!

    private var cancellables: Set<AnyCancellable> = Set()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.title = "Dictionary"

        let homeView = HomeView(viewModel: viewModel.item)
        let hosting = UIHostingController(rootView: homeView)
        hosting.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(hosting)

        view.addSubview(hosting.view)

        hosting.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        hosting.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        hosting.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        hosting.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        hosting.didMove(toParent: self)

        viewModel.viewDidLoad()
    }

    private func hideLoading() {}

    private func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        self.navigationController?.present(alert, animated: true, completion: nil)
    }
}
