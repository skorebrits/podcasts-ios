//
//  ErrorPresenter.swift
//  podcasts-ios
//
//  Created by Sander Korebrits on 01/03/2026.
//

import Foundation

struct ErrorPresenter: Presenter {

    static func present(_ error: PodCastError) -> ErrorViewData {
        .init(
            errorTItle:  mapLabel(error),
            errorRetryButton: .init(localized: "error.button.retry")
        )
    }

    private static func mapLabel(_ error: PodCastError) -> String {
        return switch error {
        case .offline:
            .init(localized: "error.title.offline")
        case .timeOut:
            .init(localized: "error.title.timeout")
        case .server:
            .init(localized: "error.title.server")
        }
    }
}
