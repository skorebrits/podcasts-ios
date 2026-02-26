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
        let urlError = URLError(.badServerResponse)
        enum TestError: Error {
            case test
            case otherTest
        }
        
        // Act
        let sutA = PodCastError(error: PodCastError.decodingError)
        let sutB = PodCastError(error: urlError)
        let sutC = PodCastError(error: ConverterError.converterError(error: NSError()))
        let sutD = PodCastError(error: TestError.test)
        
        // Assert
        #expect(sutA == PodCastError.decodingError)
        guard case .network(let error) = sutB else {
            Issue.record("Expected .network")
            return
        }
        
        let lhr = error as NSError
        let rhr = urlError as NSError
        
        #expect(lhr.code == rhr.code)
        #expect(lhr.domain == rhr.domain)
        #expect(sutC == PodCastError.decodingError)
        
        guard
            case .network(let error) = sutD,
            let testError = error as? TestError else {
            Issue.record("Expected .network")
            return
        }
        
        #expect(testError == TestError.test)
    }
    
    @Test("test podCastError return error on URLRespone")
    func testUrlRespsonseError() throws {
        // Arrange
        let url = try #require(URL(string: "https://example.com"))
        let urlResponse = URLResponse(url: url, mimeType: nil, expectedContentLength: 1, textEncodingName: nil)
        let validHTTPURLResponse = try #require(HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        ))
        let inValidHTTPURLResponse = try #require(HTTPURLResponse(
            url: url,
            statusCode: 400,
            httpVersion: nil,
            headerFields: nil
        ))
        
        // Act
        let sutA = PodCastError(response: urlResponse)
        let sutB = PodCastError(response: validHTTPURLResponse)
        let sutC = PodCastError(response: inValidHTTPURLResponse)
        
        // Assert
        #expect(sutA == PodCastError.server(statusCode: -1))
        #expect(sutB == nil)
        #expect(sutC == PodCastError.server(statusCode: 400))
    }
    
    @Test("test PodcastError == operator correctly compares errors")
    func testEquatable() {
        // server equality
        #expect(PodCastError.server(statusCode: 200) == PodCastError.server(statusCode: 200))
        #expect(PodCastError.server(statusCode: 200) != PodCastError.server(statusCode: 404))

        // decodingError equality
        #expect(PodCastError.decodingError == PodCastError.decodingError)

        // network equality - same error
        let urlError = URLError(.badServerResponse)
        #expect(PodCastError.network(error: urlError) == PodCastError.network(error: urlError))

        // network inequality - different errors
        let otherUrlError = URLError(.notConnectedToInternet)
        #expect(PodCastError.network(error: urlError) != PodCastError.network(error: otherUrlError))

        // default - mixed cases
        #expect(PodCastError.decodingError != PodCastError.server(statusCode: 200))
        #expect(PodCastError.network(error: urlError) != PodCastError.server(statusCode: 200))
        #expect(PodCastError.server(statusCode: 200) != PodCastError.decodingError)
    }
}
