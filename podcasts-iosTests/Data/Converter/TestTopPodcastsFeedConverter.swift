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
    
    @Test("test converter returns response when converting data")
    func testValidJSON() throws {
        // Arrange
        let data = try #require(FeedFixtures.validFeedJSON.data(using: .utf8))

        let sut = TopPodcastsFeedConverter()
        
        // Act
        let response = try sut.convert(data: data)
        
        // Assert
        #expect(response.feed.title == "Topprogramma's")
        #expect(response.feed.results.count == 3)
    }
    
    @Test("test converter returns response when converting empy feed")
    func testEmptyFeed() throws {
        // Arrange
        let data = try #require(FeedFixtures.emptyResultsFeedJSON.data(using: .utf8))

        let sut = TopPodcastsFeedConverter()
        
        // Act
        let response = try sut.convert(data: data)
        
        // Assert
        #expect(response.feed.results.isEmpty)
    }
    
    @Test("test converter throws when converting malformed feed")
    func testMalformedFeed () throws {
        // Arrange
        let data =  try #require(FeedFixtures.malformedFeedJSON.data(using: .utf8))

        let sut = TopPodcastsFeedConverter()
        
        // Assert
        #expect(throws: (any Error).self) {
            // Act
            _ = try sut.convert(data: data)
        }
    }
}


