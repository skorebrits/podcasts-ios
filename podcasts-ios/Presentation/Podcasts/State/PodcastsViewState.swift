//
//  PodcastsViewState.swift
//  podcasts-ios
//
//  Created by Sander Korebrits on 26/02/2026.
//

enum PodcastsViewState {
    case loading(LoadingViewData)
    case error(ErrorViewData)
    case loaded(PodcastsFeedViewData)
}
