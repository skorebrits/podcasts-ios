//
//  TestTopPodcastsFeedConverter.swift
//  podcasts-ios
//
//  Created by Sander Korebrits on 26/02/2026.
//

import Testing
import Foundation

@testable import podcasts_ios

struct TestTopPodcastsFeedConverter {
    
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
    
    private let emptyResultsFeedJSON = """
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
                    "results": []
                }
        }
        """
    
    private let malformedFeedJSON = """
                    {
                        "feed1": {}
                    }
        """
    
    
    @Test("test converter returns response when converting data")
    func testValidJSON() async throws {
        // Arrange
        let data = try #require(validFeedJSON.data(using: .utf8))

        let sut = TopPodcastsFeedConverter()
        
        // Act
        let response = try await sut.convert(data: data)
        
        // Assert
        await #expect(response.feed.title == "Topprogramma's")
        await #expect(response.feed.results.count == 3)
    }
    
    @Test("test converter returns response when converting empy feed")
    func testEmptyFeed() async throws {
        // Arrange
        let data = try #require(emptyResultsFeedJSON.data(using: .utf8))

        let sut = TopPodcastsFeedConverter()
        
        // Act
        let response = try await sut.convert(data: data)
        
        // Assert
        await #expect(response.feed.results.isEmpty)
    }
    
    @Test("test converter throws when converting malformed feed")
    func testMalformedFeed () async throws {
        // Arrange
        let data =  try #require(malformedFeedJSON.data(using: .utf8))

        let sut = TopPodcastsFeedConverter()
        
        // Assert
        await #expect(throws: (any Error).self) {
            // Act
            _ = try await sut.convert(data: data)
        }
    }
}


