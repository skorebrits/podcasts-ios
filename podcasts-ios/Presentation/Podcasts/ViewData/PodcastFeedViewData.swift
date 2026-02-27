//
//  PodcastFeedViewData.swift
//  podcasts-ios
//
//  Created by Sander Korebrits on 27/02/2026.
//

struct PodcastsFeedViewData {
    var title: String
    var cells: [PodcastsCellViewData]
}

struct PodcastsCellViewData: Identifiable {
    var id: String
    var label: String
    var secondaryLabel: String
    var imageURL: String
}
