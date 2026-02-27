//
//  PodcastsPresenter.swift
//  podcasts-ios
//
//  Created by Sander Korebrits on 26/02/2026.
//

import Foundation

struct PodcastsPresenter {
    static func viewDataFrom(error: PodCastError) -> ErrorViewData {
        .init(
            errorLabel: "Error: \(error.localizedDescription)",
            errorRetryButton: "Try again"
        )
    }

    static func viewDataFrom(feed: Feed) -> PodcastsFeedViewData {
        .init(
            title: feed.title,
            cells: feed.podcasts.map {
                PodcastsCellViewData(
                    id: $0.id,
                    label: $0.name,
                    secondaryLabel: $0.artist,
                    imageURL: $0.artworkUrl
                )
            }
        )
    }

    static func loadingViewData() -> LoadingViewData {
        .init(label: "Loading...")
    }
}
