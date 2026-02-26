//
//  TestPodcastService.swift
//  podcasts-ios
//
//  Created by Sander Korebrits on 26/02/2026.
//

import Testing
import Foundation

@testable import podcasts_ios

struct TestPodcastService {
    
    @Test("test service returns response from request")
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
        
        let sut = PodcastService(isUrlSession: urlSession, converter: .init())

        // Act
        let response = try await sut.fectchTopPodCast()

        // Assert
        await #expect(response.feed.results.count == 3)
    }
    
    @Test("test service throws error invalid status code")
    func testFetchPodcastsInvalidStatusCode() async throws {
        // Arrange
        let request: URLRequest = .topPodcastsFeedRequest()
        let url = try #require(request.url)
        let httpResponse = HTTPURLResponse(
            url: url,
            statusCode: 400,
            httpVersion: nil,
            headerFields: nil
        )!
        let data = Data()
        let urlSession = IsURLSessionStub(returnValue: (data, httpResponse), error: nil)
        
        let sut = PodcastService(isUrlSession: urlSession, converter: .init())

        // Assert
        await #expect(throws: PodCastError.server(statusCode: 400)) {
            // Act
            _ =  try await sut.fectchTopPodCast()
        }
    }
    
    
    @Test("test service throws error on url response")
    func testFetchPodcastsServerErrorURLResponse() async throws {
        // Arrange
        let urlResponse = URLResponse()
        let data = Data()
        let urlSession = IsURLSessionStub(returnValue: (data, urlResponse), error: nil)
        
        let sut = PodcastService(isUrlSession: urlSession, converter: .init())
        
        // Assert
        await #expect(throws: PodCastError.server(statusCode: -1)) {
            // Act
            _ =  try await sut.fectchTopPodCast()
        }
    }
    
    @Test("test service throws error on decoding")
    func testFetchPodcastsDecodingError() async throws {
        // Arrange
        let request: URLRequest = .topPodcastsFeedRequest()
        let url = try #require(request.url)
        let httpResponse = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        let data = try #require(FeedFixtures.malformedFeedJSON.data(using: .utf8))
        let urlSession = IsURLSessionStub(returnValue: (data, httpResponse), error: nil)
        
        let sut = PodcastService(isUrlSession: urlSession, converter: .init())
        
        // Assert
        await #expect(throws: PodCastError.decodingError) {
            // Act
            _ =  try await sut.fectchTopPodCast()
        }
    }
    
    @Test("test service throws error on network")
    func testFetchPodcastsNetworkError() async throws {
        // Arrange
        let request: URLRequest = .topPodcastsFeedRequest()
        let url = try #require(request.url)
        let httpResponse = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        let data = Data()
        let error = URLError(.networkConnectionLost)
        let urlSession = IsURLSessionStub(returnValue: (data, httpResponse), error: error)
        
        let sut = PodcastService(isUrlSession: urlSession, converter: .init())
        
        // Assert
        await #expect(throws: PodCastError.network(error: error)) {
            // Act
            _ =  try await sut.fectchTopPodCast()
        }
    }
}
