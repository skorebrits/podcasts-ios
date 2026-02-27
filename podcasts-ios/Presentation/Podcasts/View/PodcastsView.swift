//
//  PodcastsView.swift
//  podcasts-ios
//
//  Created by Sander Korebrits on 26/02/2026.
//

import SwiftUI

struct PodcastsView: View {
    @State private var viewModel = PodcastsViewModel()

    var body: some View {
        Group {
            switch viewModel.state {
            case .loading(let loadingViewData):
                LoadingView(viewData: loadingViewData)
            case .error(let errorViewData):
                ErrorView(viewData: errorViewData) {
                    Task {
                        await viewModel.load()
                    }
                }
            case .loaded(let feedViewData):
                VStack {
                    Text(feedViewData.title).font(.largeTitle)

                    List(feedViewData.cells) { cell in
                        PodcastsCellView(viewData: cell)
                    }
                }
            }
        }
        .task {
            await viewModel.load()
        }
    }
}

#Preview {
    PodcastsView()
}
