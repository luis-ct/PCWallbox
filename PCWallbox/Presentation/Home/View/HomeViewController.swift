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
    var viewModel: HomeViewModel!

    private var cancellables: Set<AnyCancellable> = Set()
    private var items: [CharacterItem] = []

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

    private func charactersReceived(_ state: StateViewModel<[CharacterItem]>) {
        switch state {
        case .initial:
            hideLoading()
            self.items = []
        case .loading:
            showLoading()
        case .success(let items):
            hideLoading()
            self.items = items
        case .failure(let error):
            hideLoading()
            showError(error)
        }
    }

    private func showLoading() {
        let view = UIView(frame: .zero)
        let activityIndicatorView = addLoading(view: view)
        activityIndicatorView.startAnimating()
    }

    private func hideLoading() {}

    private func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        self.navigationController?.present(alert, animated: true, completion: nil)
    }
}

extension HomeViewController: LoadingProtocol {}
