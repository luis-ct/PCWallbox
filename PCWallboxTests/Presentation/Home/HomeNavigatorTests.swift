//
//  HomeNavigatorTests.swift
//  PCWallboxTests
//
//  Created by Luis Cañadas on 12/7/22.
//

import XCTest
@testable import PCWallbox

class HomeNavigatorTests: WindowXCTestCase {
    private var sut: HomeNavigator!
    private var navigationController: UINavigationController!
    private var viewController: HomeViewController!
    private var viewModel: HomeViewModelDummy!

    override func setUpWithError() throws {
        try super.setUpWithError()
        self.navigationController = UINavigationController(rootViewController: UIViewController())
        self.viewController = HomeViewController()
        self.viewModel = HomeViewModelDummy()
        viewController.viewModel = viewModel

        self.sut = HomeNavigator()
        sut.navigationController = navigationController
        sut.view = viewController

        loadViewInWindow(view: navigationController)
    }


    func test_start() throws {
        let expect = expectation(description: #function)

        sut.start()
        self.asyncCompletion {
            expect.fulfill()
            XCTAssertTrue(self.navigationController.viewControllers.first === self.viewController)
        }

        wait()
    }
}

private class HomeViewModelDummy: HomeViewModelProtocol {
    var item = HomeItem()

    func viewDidLoad() {}
}
