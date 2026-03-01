//
//  PodcastError.swift
//  podcasts-ios
//
//  Created by Sander Korebrits on 26/02/2026.
//

import Foundation

enum PodCastError: Error, Equatable {
    case server
    case timeOut
    case offline

    init(error: Error) {
        switch error {
        case let urlError as URLError:
            self = .init(urlError: urlError)

        default:
            self = .server
        }
    }

    init(urlError: URLError) {
        switch urlError.code {
        case .timedOut:
            self = .timeOut

        case .notConnectedToInternet,
                .networkConnectionLost:
            self = .offline

        default:
            self = .server
        }
    }
}
