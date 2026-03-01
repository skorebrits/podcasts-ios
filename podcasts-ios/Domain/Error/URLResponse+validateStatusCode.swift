//
//  URLResponse+Validate.swift
//  podcasts-ios
//
//  Created by Sander Korebrits on 01/03/2026.
//

import Foundation

extension URLResponse {

    func validateStatusCode() throws {
        guard let httpResponse = self as? HTTPURLResponse else {
            throw PodCastError.server
        }

        if !(200..<300).contains(httpResponse.statusCode) {
            throw PodCastError.server
        }
    }
}
