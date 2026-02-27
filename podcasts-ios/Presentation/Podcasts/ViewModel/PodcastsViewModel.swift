//
//  PodcastsViewModel.swift
//  podcasts-ios
//
//  Created by Sander Korebrits on 26/02/2026.
//

import SwiftUI

@Observable
final class PodcastsViewModel {
    var state: PodcastsViewState = .loading(PodcastsPresenter.loadingViewData())

    private let repository: PodcastsRepository

    init(repository: PodcastsRepository = .init(podcastService: PodcastService())) {
        self.repository = repository
    }

    func load() async {
        do {
            let feed = try await self.repository.fetchPodcastsFeed()
            let feedViewData = PodcastsPresenter.viewDataFrom(feed: feed)
            self.state = .loaded(feedViewData)
        } catch {
            let podcastError = PodCastError(error: error)
            let errorViewData = PodcastsPresenter.viewDataFrom(error: podcastError)
            self.state = .error(errorViewData)
        }
    }
}
