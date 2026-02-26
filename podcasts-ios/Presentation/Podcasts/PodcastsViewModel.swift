//
//  PodcastsViewModel.swift
//  podcasts-ios
//
//  Created by Sander Korebrits on 26/02/2026.
//

import SwiftUI

@Observable
@MainActor
class PodcastsViewModel {
    var state: PodcastsViewState = .loading

    private let repository: PodcastsRepository

    init(repository: PodcastsRepository = .init(podcastService: PodcastService())) {
        self.repository = repository
    }

    func load() async {
        do {
            let feed = try await self.repository.fetchPodcastsFeed()
            self.state = .loaded(feed)
        } catch {
            self.state = .error(PodCastError(error: error))
        }
    }
}
