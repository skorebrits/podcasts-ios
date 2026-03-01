//
//  TopPodcastsFeecConverter.swift
//  podcasts-ios
//
//  Created by Sander Korebrits on 26/02/2026.
//

import Foundation

struct TopPodcastsFeedConverter {

    private let jsonDecoder: JSONDecoder

    init(jsonDecoder: JSONDecoder = .init()) {
        self.jsonDecoder = jsonDecoder
    }

    func convert(data: Data) throws -> TopPodcastsResponse {
        try jsonDecoder.decode(TopPodcastsResponse.self, from: data)
    }
}
