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
    
    private let validFeedJSON = """
        {
            "feed": {
                "title": "Topprogramma's",
                "id": "https://rss.marketingtools.apple.com/api/v2/nl/podcasts/top/10/podcasts.json",
                "author": {
                    "name": "Apple",
                    "url": "https://www.apple.com/"
                },
                "links": [
                    {
                        "self": "https://rss.marketingtools.apple.com/api/v2/nl/podcasts/top/10/podcasts.json"
                    }
                ],
                "copyright": "Copyright © 2026 Apple Inc. All rights reserved.",
                "country": "nl",
                "icon": "https://www.apple.com/favicon.ico",
                "updated": "Thu, 26 Feb 2026 09:55:31 +0000",
                "results": [
                    {
                        "artistName": "Tom Jessen en Maarten van Rossem",
                        "id": "1513807137",
                        "name": "Maarten van Rossem en Tom Jessen",
                        "kind": "podcasts",
                        "artworkUrl100": "https://is1-ssl.mzstatic.com/image/thumb/Podcasts126/v4/f5/a6/6d/f5a66dbd-6faf-86b6-f43d-2457f288e3b3/mza_5767015447653460511.jpg/100x100bb.png",
                        "genres": [
                            {
                                "genreId": "1489",
                                "name": "Nieuws",
                                "url": "https://itunes.apple.com/nl/genre/id1489"
                            }
                        ],
                        "url": "https://podcasts.apple.com/nl/podcast/maarten-van-rossem-en-tom-jessen/id1513807137"
                    },
                    {
                        "artistName": "BNR Nieuwsradio",
                        "id": "1076289388",
                        "name": "Boekestijn en De Wijk",
                        "kind": "podcasts",
                        "artworkUrl100": "https://is1-ssl.mzstatic.com/image/thumb/Podcasts112/v4/7d/f0/e7/7df0e76d-b705-cf2a-94c6-a10ff291497e/mza_16718794314625024290.jpg/100x100bb.png",
                        "genres": [
                            {
                                "genreId": "1489",
                                "name": "Nieuws",
                                "url": "https://itunes.apple.com/nl/genre/id1489"
                            }
                        ],
                        "url": "https://podcasts.apple.com/nl/podcast/boekestijn-en-de-wijk/id1076289388"
                    },
                    {
                        "artistName": "Lars van Eijden & Rick Uilenbroek / Audiohuis",
                        "id": "1869274600",
                        "name": "SEXTORTION",
                        "kind": "podcasts",
                        "artworkUrl100": "https://is1-ssl.mzstatic.com/image/thumb/Podcasts221/v4/29/84/b7/2984b72b-46fc-ba05-d030-21d1e538d51a/mza_1684894744550769464.jpg/100x100bb.png",
                        "genres": [
                            {
                                "genreId": "1324",
                                "name": "Maatschappij en cultuur",
                                "url": "https://itunes.apple.com/nl/genre/id1324"
                            },
                            {
                                "genreId": "1488",
                                "name": "Waargebeurde misdaad",
                                "url": "https://itunes.apple.com/nl/genre/id1488"
                            }
                        ],
                        "url": "https://podcasts.apple.com/nl/podcast/sextortion/id1869274600"
                    }
                ]
            }
        }
        """
    
    private let malformedFeedJSON = """
                    {
                        "feed1": {}
                    }
        """
    
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
        let data = try #require(validFeedJSON.data(using: .utf8))
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
        let data = try #require(malformedFeedJSON.data(using: .utf8))
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
