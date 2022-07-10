//
//  LoadingProtocol.swift
//  PCWallbox
//
//  Created by Luis Cañadas Treceño on 11/3/22.
//

import UIKit

protocol LoadingProtocol {
    func addLoading(view: UIView) -> UIActivityIndicatorView
}

extension LoadingProtocol where Self: UIViewController {
    func addLoading(view: UIView) -> UIActivityIndicatorView {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.hidesWhenStopped = true
        view.addSubview(activityIndicatorView)

        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        return activityIndicatorView
    }
}
