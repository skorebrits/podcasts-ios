//
//  TestPodcastsRepository.swift
//  podcasts-ios
//
//  Created by Sander Korebrits on 26/02/2026.
//

import Testing
import Foundation

@testable import podcasts_ios

struct TestPodcastsRepository {
    
    @Test("test PodcastsRepository returns feed")
    func testFetchPodcasts() async throws {
        // Arrange
        let request: URLRequest = .topPodcastsFeedRequest()
        let url = try #require(request.url)
        let httpResponse = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        let data = try #require(FeedFixtures.validFeedJSON.data(using: .utf8))
        let urlSession = IsURLSessionStub(returnValue: (data, httpResponse), error: nil)
        let service = PodcastService(isUrlSession: urlSession)
        
        let sut = PodcastsRepository(podcastService: service)
        
        // Act
        let feed = try await sut.fetchPodcastsFeed()
        
        // Assert
        #expect(feed.title == "Topprogramma's")
        #expect(feed.podcasts.count == 3)
    }
}
