//
//  TranslatorUseCaseTests.swift
//  PCWallboxTests
//
//  Created by Luis Cañadas on 12/7/22.
//

import XCTest
import Combine
@testable import PCWallbox

class TranslatorUseCaseTests: XCTestCase {
    private var sut: TranslatorUseCase!

    private var repository: TranslateRepositoryStub!

    override func setUpWithError() throws {
        try super.setUpWithError()
        self.repository = TranslateRepositoryStub()
        self.sut = TranslatorUseCase(input: "", repository: repository)
    }

    func test_translation_is_success() throws {
        let expect = expectation(description: #function)

        let translated = "ABCDDEFG"
        repository.translated = translated
        sut.output = { result in
            expect.fulfill()
            switch result {
            case .failure:
                XCTFail()
            case .success(let value):
                XCTAssertEqual(value, translated)
            }
        }
        sut.run()
        wait()
    }

    func test_translation_is_failure() throws {
        let expect = expectation(description: #function)

        sut.output = { result in
            expect.fulfill()
            switch result {
            case .failure:
                XCTAssert(true)
            case .success:
                XCTFail()
            }
        }
        sut.run()
        wait()
    }
}

private class TranslateRepositoryStub: TranslateRepositoryProtocol {
    var translated: String?

    func translate(text: String) -> AnyPublisher<String, Error> {
        guard let translated = translated else {
            return Fail(error: RepositoryDataError.noData).eraseToAnyPublisher()
        }
        return Just(translated).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}
