//
//  CharacterRepositoryTests.swift
//  Game of Thrones ProjectTests
//
//  Created by Andy Heredia on 15/4/25.
//

import XCTest
@testable import Game_of_Thrones_Project

final class CharacterRepositoryTests: XCTestCase {
    
    var mockNetwork: CharacterNetworkMock!
    var mockRepository: CharacterRepositoryMock!

    override func setUpWithError() throws {
        // Given: Create mock characters to simulate a successful network response
        let character1 = GOTResponse(
            id: 1,
            firstName: "Jon",
            lastName: "Snow",
            fullName: "Jon Snow",
            title: "King of the North",
            family: "House Stark",
            imageUrl: "https://thronesapi.com/assets/images/jon-snow.jpg"
        )
        
        let character2 = GOTResponse(
            id: 2,
            firstName: "Daenerys",
            lastName: "Targaryen",
            fullName: "Daenerys Targaryen",
            title: "Mother of Dragons",
            family: "House Targaryen",
            imageUrl: "https://thronesapi.com/assets/images/daenerys.jpg"
        )
        
        mockNetwork = CharacterNetworkMock(resultToReturn: .success([character1, character2]))
        mockRepository = CharacterRepositoryMock(network: mockNetwork)
    }

    override func tearDownWithError() throws {
        mockNetwork = nil
        mockRepository = nil
    }

    func testCharacterRepository_returnsExpectedCharacters() throws {
       // Given
        let expectation = expectation(description: "Should return characters succesfully")
    
        // When
        mockRepository.getCharacters { result in
            switch result {
                // Then
            case .success(let characters):
                XCTAssertEqual(characters.count, 2)
                
                let jon = characters[0]
                XCTAssertEqual(jon.firstName, "Jon")
                XCTAssertEqual(jon.lastName, "Snow")
                XCTAssertEqual(jon.fullName, "Jon Snow")
                XCTAssertEqual(jon.title, "King of the North")
                XCTAssertEqual(jon.family, "House Stark")
                XCTAssertEqual(jon.imageUrl, "https://thronesapi.com/assets/images/jon-snow.jpg")
                
                let daenerys = characters[1]
                XCTAssertEqual(daenerys.firstName, "Daenerys")
                XCTAssertEqual(daenerys.lastName, "Targaryen")
                XCTAssertEqual(daenerys.fullName, "Daenerys Targaryen")
                XCTAssertEqual(daenerys.title, "Mother of Dragons")
                XCTAssertEqual(daenerys.family, "House Targaryen")
                XCTAssertEqual(daenerys.imageUrl, "https://thronesapi.com/assets/images/daenerys.jpg")
                
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Expected success but got failure with error: \(error)")
            }
        }
      
        wait(for: [expectation], timeout: 2)
    }


}
