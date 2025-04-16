//
//  HttpResponseCodeTests.swift
//  Game of Thrones ProjectTests
//
//  Created by Andy Heredia on 16/4/25.
//

import XCTest
@testable import Game_of_Thrones_Project

final class HttpResponseCodeTests: XCTestCase {

 
    func testHttpResponseCode_rawValues_shouldReturnCorrectHTTPInt() {
        XCTAssertEqual(HttpResponseCode.SUCCESS, 200)
        XCTAssertEqual(HttpResponseCode.ERROR, 502)
        XCTAssertEqual(HttpResponseCode.NOT_AUTHORIZED, 400)
    }

}
