//
//  PodcastRepository.swift
//  podcasts-ios
//
//  Created by Sander Korebrits on 26/02/2026.
//

actor PodcastsRepository {

    private let podcastService: PodcastService

    init(podcastService: PodcastService) {
        self.podcastService = podcastService
    }

    func fetchPodcastsFeed() async throws -> Feed {
        let response = try await podcastService.fectchTopPodCast()
        return FeedMapper.map(response.feed)
    }
}
