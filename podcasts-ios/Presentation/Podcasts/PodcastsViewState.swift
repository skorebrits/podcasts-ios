//
//  PodcastsViewState.swift
//  podcasts-ios
//
//  Created by Sander Korebrits on 26/02/2026.
//

enum PodcastsViewState: Equatable {
    case loading
    case error(ErrorViewData)
    case loaded(Feed)

    static func == (lhs: PodcastsViewState, rhs: PodcastsViewState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true

        case (.error(_), .error(_)):
            return true

        case (.loaded(_), .loaded(_)):
            return true

        default:
            return false
        }
    }
}
