//
//  PodcastsPresenter.swift
//  podcasts-ios
//
//  Created by Sander Korebrits on 26/02/2026.
//

import Foundation

struct PodcastsPresenter {
    static func viewDataFrom(error: PodCastError) -> ErrorViewData {
        ErrorViewData(
            errorLabel: "Error: \(error.localizedDescription)",
            errorRetryButton: "Try again"
        )
    }
}
