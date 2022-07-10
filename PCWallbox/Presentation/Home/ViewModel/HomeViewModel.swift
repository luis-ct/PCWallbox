//
//  HomeViewModel.swift
//  PCWallbox
//
//  Created by Luis Cañadas Treceño on 6/3/22.
//

import Foundation
import Combine

class HomeViewModel: HomeViewModelProtocol {
    var navigator: HomeNavigatorProtocol!

    let characters: CurrentValueSubject<StateViewModel<[CharacterItem]>, Never> = CurrentValueSubject(.initial)
    var charactersDO: [CharacterDO] = []

    private let useCase: ListUseCase

    init(
        useCase: ListUseCase
    ) {
        self.useCase = useCase
    }

    func viewDidLoad() {
        getCharacters()
    }

    func selectCharacter(at index: Int) {}
    
    private func getCharacters() {
        characters.send(.loading)
        useCase.output = { [weak self] result in
            switch result {
            case .success(let output):
                self?.getCharactersSuccess(output)
            case .failure(let error):
                self?.characters.send(.failure(error))
            }
        }
        useCase.run()
    }

    private func getCharactersSuccess(_ output: [CharacterDO]) {
        self.charactersDO = output
        let items = output.compactMap { CharacterItem(name: $0.name, image: $0.image) }
        characters.send(.success(items))
    }
}
