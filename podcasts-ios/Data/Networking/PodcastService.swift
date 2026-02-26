//
//  PodcastService.swift
//  podcasts-ios
//
//  Created by Sander Korebrits on 26/02/2026.
//

import Foundation

enum PodCastServiceError: Error, Equatable {
    case server(statusCode: Int)
    case network(error: Error)
    case decodingError

    static func == (lhs: PodCastServiceError, rhs: PodCastServiceError) -> Bool {
        switch (lhs, rhs) {

        case let (.server(lhsCode), .server(rhsCode)):
            return lhsCode == rhsCode

        case (.decodingError, .decodingError):
            return true

        case let (.network(lhsError), .network(rhsError)):
            // Compare underlying NSError
            let lhsNSError = lhsError as NSError
            let rhsNSError = rhsError as NSError
            return lhsNSError.domain == rhsNSError.domain &&
                   lhsNSError.code == rhsNSError.code

        default:
            return false
        }
    }
}

actor PodcastService {

    private let isUrlSession: IsURLSession
    private let converter: TopPodcastsFeedConverter

    init(isUrlSession: IsURLSession = URLSession.shared, converter: TopPodcastsFeedConverter = .init()) {
        self.isUrlSession = isUrlSession
        self.converter = converter
    }

    func fectchTopPodCast() async throws -> TopPodcastsResponse {
        do {
            let (data, response) = try await isUrlSession.data(for: .topPodcastsFeedRequest(), delegate: nil)
            try validateResponse(response)
            return try await converter.convert(data: data)
        } catch let error {
            throw mapError(error)
        }
    }

    private func validateResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw PodCastServiceError.server(statusCode: -1)
        }
        guard 200..<300 ~= httpResponse.statusCode else {
            throw PodCastServiceError.server(statusCode: httpResponse.statusCode)
        }
    }

    private func mapError(_ error: Error) -> PodCastServiceError {
        switch error {
        case let urlError as URLError:
            return .network(error: urlError)
        case is ConverterError:
            return .decodingError
        case let podcastServiceError as PodCastServiceError:
            return podcastServiceError
        default:
            return .network(error: error)
        }
    }
}
