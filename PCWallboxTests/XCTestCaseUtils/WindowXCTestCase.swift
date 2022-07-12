//
//  WindowXCTestCase.swift
//  PCWallboxTests
//
//  Created by Luis Cañadas on 12/7/22.
//

import XCTest

class WindowXCTestCase: XCTestCase {
    private var window: UIWindow?

    func loadViewInWindow(view: UIViewController, bounds: CGRect = UIScreen.main.bounds) {
        let window = UIWindow(frame: bounds)
        window.rootViewController = view
        window.makeKeyAndVisible()
        view.view.layoutIfNeeded()
        self.window = window
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        window?.rootViewController = UIViewController()
        self.window = nil
    }
}
