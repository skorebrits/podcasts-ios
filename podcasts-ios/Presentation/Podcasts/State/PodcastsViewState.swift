//
//  PodcastsViewState.swift
//  podcasts-ios
//
//  Created by Sander Korebrits on 26/02/2026.
//

enum PodcastsViewState: Equatable {
    case loading(LoadingViewData)
    case error(ErrorViewData)
    case loaded(PodcastsFeedViewData)

    static func == (lhs: PodcastsViewState, rhs: PodcastsViewState) -> Bool {
        return switch (lhs, rhs) {
        case (.loading, .loading):
            true

        case (.error, .error):
            true

        case (.loaded, .loaded):
            true

        default:
            false
        }
    }
}
