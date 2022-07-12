//
//  XCTestCaseUtils.swift
//  PCWallboxTests
//
//  Created by Luis Cañadas on 12/7/22.
//

import XCTest

extension XCTestCase {
    func wait(timeout: TimeInterval = 5) {
        waitForExpectations(timeout: timeout) { (error) in
            guard let e = error else {
                return
            }
            print("Error: \(e.localizedDescription)")
            XCTFail()
        }
    }

    func arrange(_ arrange: @escaping () -> (), assert: @escaping () -> (), milliseconds: Int = 1000) {
        let assertCompletion = {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(milliseconds)) {
                assert()
            }
        }

        let actCompletion = {
            arrange()
            assertCompletion()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(milliseconds)) {
            actCompletion()
        }
    }

    func asyncCompletion(_ arrange: @escaping () -> (), milliseconds: Int = 1000) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(milliseconds)) {
            arrange()
        }
    }
}
