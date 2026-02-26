//
//  IsURLSessionStub.swift
//  podcasts-ios
//
//  Created by Sander Korebrits on 26/02/2026.
//

import Foundation

@testable import podcasts_ios

final class IsURLSessionStub: IsURLSession {
    
    private let returnValue: (Data, URLResponse)
    private let error: URLError?
    
    init(returnValue: (Data, URLResponse), error: URLError? ) {
        self.returnValue = returnValue
        self.error = error
    }
    
    func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        guard error == nil else {
            throw error!
        }
        
        return returnValue
    }
}
