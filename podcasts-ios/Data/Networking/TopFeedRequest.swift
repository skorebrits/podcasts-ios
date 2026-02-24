//
//  TopFeedRequest.swift
//  podcasts-ios
//
//  Created by Sander Korebrits on 24/02/2026.
//

import Foundation

extension URLRequest {

    static func topFeedRequest() -> URLRequest {
        // swiftlint:disable:next force_unwrapping
        URLRequest(url:
                    URL(string: "https://rss.marketingtools.apple.com/api/v2/nl/podcasts/top/25/podcasts.json")!
        )
    }
}
