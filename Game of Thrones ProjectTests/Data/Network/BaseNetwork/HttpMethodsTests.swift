//
//  HttpMethodsTests.swift
//  Game of Thrones ProjectTests
//
//  Created by Andy Heredia on 16/4/25.
//

import XCTest
@testable import Game_of_Thrones_Project



final class HttpMethodsTests: XCTestCase {
    
    func testHttpMethods_rawValues_shouldReturnCorrectHTTPStrings() throws {
        XCTAssertEqual(HttpMethods.get, "GET")
        XCTAssertEqual(HttpMethods.post, "POST")
        XCTAssertEqual(HttpMethods.delete, "DELETE")
        XCTAssertEqual(HttpMethods.put, "PUT")
    }
    
}
