//
//  TestPocastError.swift
//  podcasts-ios
//
//  Created by Sander Korebrits on 26/02/2026.
//

import Testing
import Foundation

@testable import podcasts_ios

struct TestPodcastError {
    
    @Test("test podCastError returns correct Error")
    func testCorrectError() {
        // Arrange
        enum TestError: Error {
            case test
        }

        let urlErrorNotConnected = URLError(.notConnectedToInternet)
        let urlErrorConnectionLost = URLError(.networkConnectionLost)
        let urlErrorTimeOut = URLError(.timedOut)
        let urlErrorOtherURLError = URLError(.unknown)

        // Act
        let sutNotConnected = PodCastError(error: urlErrorNotConnected)
        let sutConnectionLost = PodCastError(error: urlErrorConnectionLost)
        let sutTimeOut = PodCastError(error: urlErrorTimeOut)
        let sutOtherURLError = PodCastError(error: urlErrorOtherURLError)
        let sutTest = PodCastError(error: TestError.test)
        
        // Assert
        #expect(sutNotConnected == PodCastError.offline)
        #expect(sutConnectionLost == PodCastError.offline)
        #expect(sutTimeOut == PodCastError.timeOut)
        #expect(sutOtherURLError == PodCastError.server)
        #expect(sutTest == PodCastError.server)
    }
}
