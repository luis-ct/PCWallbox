//
//  UseCase.swift
//  PCWallbox
//
//  Created by Luis Cañadas Treceño on 6/3/22.
//

import Foundation
import Combine

class UseCase<Input, Output> {
    var input: Input
    var output: ((Result<Output, Error>) -> ())?

    init(
        input: Input
    ) {
        self.input = input
    }

    func run() {}

    open func finish(result: Result<Output, Error>) {
        DispatchQueue.main.async {
            self.output?(result)
        }
    }
}
