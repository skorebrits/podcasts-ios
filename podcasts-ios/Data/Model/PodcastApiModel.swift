//
//  PodcastApiModel.swift
//  podcasts-ios
//
//  Created by Sander Korebrits on 24/02/2026.
//

struct PodcastApiModel: Decodable {
    let artistName: String
    let id: String
    let kind: String
    let artworkUrl100: String
    let genres: [String]
    let url: String
}
