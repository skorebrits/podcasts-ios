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
                Text("Loading....")
            case .error(let error):
                Text("Error: \(error.localizedDescription)")
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
