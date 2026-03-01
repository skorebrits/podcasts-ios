//
//  PodcastsViewModel.swift
//  podcasts-ios
//
//  Created by Sander Korebrits on 26/02/2026.
//

import SwiftUI

@Observable
final class PodcastsViewModel {

    var state: PodcastsViewState

    private let loadingState: PodcastsViewState = .loading(.init())
    private let repository: PodcastsRepository

    init(repository: PodcastsRepository = .init(podcastService: PodcastService())) {
        self.repository = repository
        self.state = loadingState
    }

    func load() async {
        do {
            state = loadingState
            let feed = try await self.repository.fetchPodcastsFeed()
            let feedViewData = PodcastsPresenter.present(feed)
            state = .loaded(feedViewData)
        } catch {
            let podcastError = PodCastError(error: error)
            let errorViewData = ErrorPresenter.present(podcastError)
            state = .error(errorViewData)
        }
    }
}
