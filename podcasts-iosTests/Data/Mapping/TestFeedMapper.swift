//
//  TestFeedMapper.swift
//  podcasts-ios
//
//  Created by Sander Korebrits on 26/02/2026.
//

import Testing

@testable import podcasts_ios

struct TestFeedMapper {
    
    @Test("test feedmapper corretly maps feed")
    func testFeedMapper() throws {
        // Arrange
        let podCastApiModel = PodcastApiModel(
            artistName: "artistName",
            id: "id",
            name: "podcast name",
            kind: "kind",
            artworkUrl100: "artwork",
            genres: [
                GenreApiModel(genreId: "", name: "genre1", url: "url"),
                GenreApiModel(genreId: "", name: "genre2", url: "url")
            ],
            url: "url"
        )
        let feedApiModel = FeedApiModel(
            title: "title",
            id: "id",
            author: AuthorApiModel(name: "author", url: "url"),
            links: [LinkApiModel(url: "url")],
            copyright: "copyright",
            country: "nl",
            icon: "icon",
            updated: "",
            results: [
                podCastApiModel
            ]
        )
        
        // Act
        let sut = FeedMapper.map(feedApiModel)
        
        // Assert
        #expect(sut.title == "title")
        #expect(sut.podcasts.count == 1)
        
        let podcast = try #require(sut.podcasts.first)
        #expect(podcast.id == "id")
        #expect(podcast.name == "podcast name")
        #expect(podcast.artist == "artistName")
        #expect(podcast.kind == "kind")
        #expect(podcast.artworkUrl == "artwork")
        #expect(podcast.url == "url")
        #expect(podcast.genres == ["genre1", "genre2"])
    }
    
    @Test("test feedmapper maps empty podcasts")
        func testFeedMapperEmptyResults() {
            // Arrange
            let feedApiModel = FeedApiModel(
                title: "title",
                id: "id",
                author: AuthorApiModel(name: "author", url: "url"),
                links: [LinkApiModel(url: "url")],
                copyright: "copyright",
                country: "nl",
                icon: "icon",
                updated: "",
                results: []
            )
            
            // Act
            let sut = FeedMapper.map(feedApiModel)
            
            // Assert
            #expect(sut.podcasts.isEmpty)
        }
}
