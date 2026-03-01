//
//  IsURLSession.swift
//  podcasts-ios
//
//  Created by Sander Korebrits on 26/02/2026.
//

import Foundation

protocol IsURLSession {
    func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse)
}
