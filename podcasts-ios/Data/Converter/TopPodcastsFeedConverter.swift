//
//  TopPodcastsFeecConverter.swift
//  podcasts-ios
//
//  Created by Sander Korebrits on 26/02/2026.
//

import Foundation

enum ConverterError: Error {
    case converterError(error: Error)
}

struct TopPodcastsFeedConverter {

    private let jsonDecoder: JSONDecoder

    init(jsonDecoder: JSONDecoder = .init()) {
        self.jsonDecoder = jsonDecoder
    }

    func convert(data: Data) async throws -> TopPodcastsResponse {
        do {
            return try jsonDecoder.decode(TopPodcastsResponse.self, from: data)
        } catch let error {
            throw ConverterError.converterError(error: error)
        }
    }
}
