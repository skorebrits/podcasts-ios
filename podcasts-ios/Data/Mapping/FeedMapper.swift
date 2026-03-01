//
//  FeedMapper.swift
//  podcasts-ios
//
//  Created by Sander Korebrits on 26/02/2026.
//

enum FeedMapper {

    static func map(_ feed: FeedApiModel) -> Feed {
        Feed(
            title: feed.title,
            podcasts: feed.results.map {
                Podcast(
                    artist: $0.artistName,
                    id: $0.id,
                    name: $0.name,
                    kind: $0.kind,
                    artworkUrl: $0.artworkUrl100,
                    url: $0.url,
                    genres: $0.genres.map(\.name)
                )
            }
        )
    }
}
