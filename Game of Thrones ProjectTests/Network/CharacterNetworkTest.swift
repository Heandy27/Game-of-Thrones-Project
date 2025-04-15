//
//  CharacterNetworkTest.swift
//  Game of Thrones ProjectTests
//
//  Created by Andy Heredia on 14/4/25.
//

import XCTest
@testable import Game_of_Thrones_Project

final class CharacterNetworkTest: XCTestCase {
    
    var sut: CharacterNetwork!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        
        sut = CharacterNetwork(urlSession: urlSession)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        MockURLProtocol.stubResponseData = nil
        sut = nil
    }
    
    func testCharacterNetwork_WhenGivenValidJSON_ReturnParsedCharacters() {
        // Given
        let jsonString = """
    [
        {
            "id": 0,
            "firstName": "Daenerys",
            "lastName": "Targaryen",
            "fullName": "Daenerys Targaryen",
            "title": "Mother of Dragons",
            "family": "House Targaryen",
            "image": "daenerys.jpg",
            "imageUrl": "https://thronesapi.com/assets/images/daenerys.jpg"
        }
    ]
    """
        
        MockURLProtocol.stubResponseData = jsonString.data(using: .utf8)
        let expectation = self.expectation(description: "Character Response Expectation")
        // When
        sut.getCharacters { result in
            switch result {
            case .success(let characters):
                //Then
                XCTAssertFalse(characters.isEmpty)
                XCTAssertEqual(characters.first?.id, 0)
                XCTAssertEqual(characters.first?.firstName, "Daenerys")
                XCTAssertEqual(characters.first?.lastName, "Targaryen")
                XCTAssertEqual(characters.first?.fullName, "Daenerys Targaryen")
                XCTAssertEqual(characters.first?.title, "Mother of Dragons")
                XCTAssertEqual(characters.first?.family, "House Targaryen")
                XCTAssertEqual(characters.first?.imageUrl, "https://thronesapi.com/assets/images/daenerys.jpg")
                expectation.fulfill()
            case .failure(let failure):
                XCTFail("Expected success, but got error: \(failure)")
            }
        }
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testCharacterNetwork_WhenGivenInvalidJSON_ShouldReturnParsingError() {
        // Given
        let jsonString = """
    [
        {
            "id": 0,
            "Name": "Daenerys",
            "lastName": "Targaryen",
            "full": "Daenerys Targaryen",
            "title": "Mother of Dragons",
            "family": "House Targaryen",
            "image": "daenerys.jpg",
            "imageUrl": "https://thronesapi.com/assets/images/daenerys.jpg"
        }
    ]
    """
        MockURLProtocol.stubResponseData = jsonString.data(using: .utf8)
        
        let expectation = self.expectation(description: "getCharacters() method expectation for a response that contains a different JSON structure")
        // When
        sut.getCharacters { result in
            switch result {
            case .success(_):
                XCTFail("Expected failure due to invalid JSON structure, but received success")
            case .failure(let failure):
                // Then
                XCTAssertEqual(failure, ErrorApp.errorParsingData)
                expectation.fulfill()
            }
        }
        self.wait(for: [expectation], timeout: 5)
        
    }
    
}
