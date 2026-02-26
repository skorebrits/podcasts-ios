//
//  PodcastError.swift
//  podcasts-ios
//
//  Created by Sander Korebrits on 26/02/2026.
//

import Foundation

enum PodCastError: Error, Equatable {
    case server(statusCode: Int)
    case network(error: Error)
    case decodingError

    static func == (lhs: PodCastError, rhs: PodCastError) -> Bool {
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

    init(error: Error) {
        switch error {
        case let podcastServiceError as PodCastError:
            self = podcastServiceError

        case let urlError as URLError:
            self = .network(error: urlError)

        case is ConverterError, is DecodingError:
            self =  .decodingError

        default:
            self = .network(error: error)
        }
    }

    init?(response: URLResponse) {
        guard let httpResponse = response as? HTTPURLResponse else {
            self = .server(statusCode: -1)
            return
        }

        guard !(200..<300).contains(httpResponse.statusCode) else {
            return nil
        }

        self = .server(statusCode: httpResponse.statusCode)
    }
}
