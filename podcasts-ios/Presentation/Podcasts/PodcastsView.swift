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
            case .loading:
                LoadingView()
            case .error(let errorViewData):
                ErrorView(viewData: errorViewData) {
                    Task {
                        await viewModel.load()
                    }
                }
            case .loaded(let feed):
                Text("Loaded:\(feed.title)")
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
