//
//  PodcastService.swift
//  podcasts-ios
//
//  Created by Sander Korebrits on 26/02/2026.
//

import Foundation

struct PodcastService {

    private let isUrlSession: IsURLSession
    private let converter: TopPodcastsFeedConverter

    init(isUrlSession: IsURLSession = URLSession.shared, converter: TopPodcastsFeedConverter = .init()) {
        self.isUrlSession = isUrlSession
        self.converter = converter
    }

    func fectchTopPodCast() async throws -> TopPodcastsResponse {
        do {
            let (data, response) = try await isUrlSession.data(for: .topPodcastsFeedRequest(), delegate: nil)
            try response.validateStatusCode()
            return try converter.convert(data: data)
        } catch let error {
            throw PodCastError(error: error)
        }
    }
}
