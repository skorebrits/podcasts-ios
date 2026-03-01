//
//  TestPodcastsViewModel.swift
//  podcasts-ios
//
//  Created by Sander Korebrits on 01/03/2026.
//

import Testing
import Foundation

@testable import podcasts_ios

struct TestPodcastsViewModel {
    
    @Test("test podcastViewModel state loading on init")
    func testPodcastViewModelStateLoadingOnInit() {
        // Arrange
        let viewModel = PodcastsViewModel()
        
        // Act
        let sut = viewModel.state
        
        guard case .loading = sut else {
            Issue.record("should be loading")
            return
        }
    }
    
    @Test("test podcastViewModel state error on offline")
    func testPodcastViewModelStateErrorOnOffline() async throws {
        // Arrange
        let viewModel = try createViewModel(error:  URLError(.notConnectedToInternet))
        
        // Act
        await viewModel.load()
        let sut = await viewModel.state
        
        guard case .error = sut else {
            Issue.record("should have error")
            return
        }
    }
    
    @Test("test podcastViewModel state loaded on succes")
    func testPodcastViewModelStateLoaded() async throws {
        // Arrange
        let viewModel = try createViewModel(error:  nil)
        
        // Act
        await  viewModel.load()
        let sut = await viewModel.state
        
        guard case .loaded = sut else {
            Issue.record("should have loaded")
            return
        }
    }
    
    private func createViewModel(error: URLError?) throws -> PodcastsViewModel {
        let request: URLRequest = .topPodcastsFeedRequest()
        let url = try #require(request.url)
        let httpResponse = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        let data = try #require(FeedFixtures.validFeedJSON.data(using: .utf8))
        let urlSession = IsURLSessionStub(returnValue: (data, httpResponse), error: error)
        let service  = PodcastService(isUrlSession: urlSession, converter: .init())
        return PodcastsViewModel(repository: PodcastsRepository(podcastService: service))
    }
}
