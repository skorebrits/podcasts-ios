//
//  PodcastsPresenter.swift
//  podcasts-ios
//
//  Created by Sander Korebrits on 26/02/2026.
//

import Foundation

struct PodcastsPresenter: Presenter {

    static func present(_ data: Feed) -> PodcastsFeedViewData {
        .init(
            title: data.title,
            cells: data.podcasts.map {
                PodcastsCellViewData(
                    id: $0.id,
                    label: $0.name,
                    secondaryLabel: $0.artist,
                    imageURL: $0.artworkUrl
                )
            }
        )
    }
}
