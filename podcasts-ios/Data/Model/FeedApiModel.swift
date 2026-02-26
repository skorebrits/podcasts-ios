//
//  FeedApiModel.swift
//  podcasts-ios
//
//  Created by Sander Korebrits on 24/02/2026.
//

struct FeedApiModel: Decodable {
    let title: String
    let id: String
    let author: AuthorApiModel
    let links: [LinkApiModel]
    let copyright: String
    let country: String
    let icon: String
    let updated: String
    let results: [PodcastApiModel]
}
