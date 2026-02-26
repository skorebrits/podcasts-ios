//
//  PodcastsViewState.swift
//  podcasts-ios
//
//  Created by Sander Korebrits on 26/02/2026.
//

enum PodcastsViewState: Equatable {
    case loading
    case error(PodCastError)
    case loaded(Feed)

    static func == (lhs: PodcastsViewState, rhs: PodcastsViewState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true

        case let (.error(lhsError), .error(rhsError)):
            return lhsError == rhsError

        case let (.loaded(lhsFeed), .loaded(rhsFeed)):
            return true

        default:
            return false
        }
    }
}
