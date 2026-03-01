//
//  TestURLResponse.swift
//  podcasts-ios
//
//  Created by Sander Korebrits on 01/03/2026.
//

import Testing
import Foundation

@testable import podcasts_ios

struct TestURLResponse {
    
    @Test("test throws Error on invalid urlResponse")
    func testInvalidHTTPURLResponse() throws {
        // Arrange
        let url = try #require(URL(string: "https://example.com"))
        let urlResponse = URLResponse(
            url: url,
            mimeType: nil,
            expectedContentLength: 0,
            textEncodingName: nil
        )
        let httpResponse = HTTPURLResponse(
            url: url,
            statusCode: 400,
            httpVersion: nil,
            headerFields: nil
        )
        
        // Assert
        #expect(throws: PodCastError.server) {
            // Act
            try urlResponse.validateStatusCode()
            try httpResponse?.validateStatusCode()
        }
    }
    
    @Test("test doesn't throw on valid urlRepsone")
    func testValidHTTPURLResponse() throws {
        // Arrange
        let url = try #require(URL(string: "https://example.com"))
        let httpResponse = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        #expect(throws: Never.self) {
            try httpResponse?.validateStatusCode()
        }
    }
}
