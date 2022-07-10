//
//  HomeView.swift
//  PCWallbox
//
//  Created by Admin on 10/7/22.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeItem

    var body: some View {
        VStack(spacing: 16.0) {
            Group {
                Text("Welcome to the dictionary")
                TextField("Search dictionary", text: $viewModel.text)
                    .textFieldStyle(.roundedBorder)
                    .disableAutocorrection(true)
                Button("Translate") {
                    viewModel.tap()
                }
            }
            .padding(.horizontal)
            switch viewModel.state {
            case .initial:
                Text("")
                Spacer()
            case .success(let output):
                Text(output)
                Spacer()
            case .failure(let error):
                Spacer()
            case .loading:
                ProgressView()
                Spacer()
            }
//            Text(viewModel.translated)
            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    @ObservedObject static var viewModel = HomeItem()

    static var previews: some View {
        viewModel.state = .loading
        return HomeView(viewModel: viewModel)
    }
}
