//
//  ConstantsAppTests.swift
//  Game of Thrones ProjectTests
//
//  Created by Andy Heredia on 16/4/25.
//

import XCTest
@testable import Game_of_Thrones_Project

final class ConstantsAppTests: XCTestCase {
    
    func testConstantsApp_rawValues_shouldReturnCorrectConstantsAppString() throws {
        XCTAssertEqual(ConstantsApp.CONS_API_URL, "https://thronesapi.com/api")
    }

}
