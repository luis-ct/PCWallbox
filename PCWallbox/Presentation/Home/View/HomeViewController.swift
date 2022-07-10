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
    private var items: [CharacterItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        let observer = viewModel.characters.sink { [weak self] value in
            self?.charactersReceived(value)
        }
        cancellables.insert(observer)

        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.title = "Marvel"

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
