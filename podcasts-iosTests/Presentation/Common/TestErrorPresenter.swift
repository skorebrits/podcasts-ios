//
//  TestErrorPresenter.swift
//  podcasts-ios
//
//  Created by Sander Korebrits on 01/03/2026.
//

import Testing
import Foundation

@testable import podcasts_ios

struct TestErrorPresenter {
    
    @Test("test errorPresenter presents offline")
    func testErrorPresentsOffline() {
        // Arrange
        let error = PodCastError.offline
        
        // Act
        let sut = ErrorPresenter.present(error)
        
        // Assert
        #expect(String(localized: "error.title.offline") == sut.errorTItle)
        #expect(String(localized: "error.button.retry") == sut.errorRetryButton)
    }
    
    @Test("test errorPresenter presents timeOut")
    func testErrorPresentsTimeOut() {
        // Arrange
        let error = PodCastError.timeOut
        
        // Act
        let sut = ErrorPresenter.present(error)
        
        // Assert
        #expect(String(localized: "error.title.timeout") == sut.errorTItle)
        #expect(String(localized: "error.button.retry") == sut.errorRetryButton)
    }
    
    @Test("test errorPresenter presents server error")
    func testErrorPresentsServerError() {
        // Arrange
        let error = PodCastError.server
        
        // Act
        let sut = ErrorPresenter.present(error)
        
        // Assert
        #expect(String(localized: "error.title.server") == sut.errorTItle)
        #expect(String(localized: "error.button.retry") == sut.errorRetryButton)
    }
}
