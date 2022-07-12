//
//  HomeViewModelTests.swift
//  PCWallboxTests
//
//  Created by Luis Cañadas on 12/7/22.
//

import XCTest
@testable import PCWallbox

class HomeViewModelTests: XCTestCase {
    private var sut: HomeViewModel!

    private var result: HomeViewModelAbstractFactoryStateImpl!

    override func setUpWithError() throws {
        try super.setUpWithError()
        self.result = HomeViewModelAbstractFactoryStateImpl()
        self.sut = HomeViewModel(abstractFactory: HomeViewModelAbstractFactoryStub(state: result))
    }

    func test_view_did_load_success_last_translation() throws {
        let translated = "Hola"
        result.resultLastTranslation = .success(translated)

        sut.viewDidLoad()

        switch self.sut.item.state {
        case .success(let value):
            XCTAssertEqual(value, translated)
        default:
            XCTFail()
        }
    }

    func test_view_did_load_failure_last_translation() throws {
        sut.viewDidLoad()
        
        switch sut.item.state {
        case .success:
            XCTFail()
        default:
            XCTAssert(true)
        }
    }

    func test_item_tap_success_translation() {
        let translated = "Luis"
        result.resultTranslator = .success(translated)

        sut.item.tap()

        switch self.sut.item.state {
        case .success(let value):
            XCTAssertEqual(value, translated)
        default:
            XCTFail()
        }
    }

    func test_item_tap_failure_translation() {
        sut.item.tap()

        switch sut.item.state {
        case .success:
            XCTFail()
        default:
            XCTAssert(true)
        }
    }
}

private class HomeViewModelAbstractFactoryStateImpl: HomeViewModelAbstractFactoryState {
    var resultTranslator: Result<TranslateUseCaseOutput, Error> = .failure(UseCaseDataError.noData)
    var resultLastTranslation: Result<TranslateUseCaseOutput, Error> = .failure(UseCaseDataError.noData)
}
