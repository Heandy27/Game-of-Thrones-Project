//
//  EndpointsTests.swift
//  Game of Thrones ProjectTests
//
//  Created by Andy Heredia on 16/4/25.
//

import XCTest
@testable import Game_of_Thrones_Project

final class EndpointsTests: XCTestCase {


    func testEndpoints_rawValues_shouldReturnCorrectEndpointString() throws {
        XCTAssertEqual(Endpoints.characters.rawValue, "/v2/characters")
    }

}
