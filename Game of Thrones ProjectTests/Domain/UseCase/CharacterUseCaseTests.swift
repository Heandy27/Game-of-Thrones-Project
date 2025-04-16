//
//  CharacterUseCaseTests.swift
//  Game of Thrones ProjectTests
//
//  Created by Andy Heredia on 16/4/25.
//

import XCTest
@testable import Game_of_Thrones_Project

final class CharacterUseCaseTests: XCTestCase {
    
    var mockNetwork: CharacterNetworkMock!
    var mockUsecase: CharacterUseCaseMock!

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
        mockUsecase = CharacterUseCaseMock(repo: CharacterRepositoryMock(network: mockNetwork))
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockNetwork = nil
        mockUsecase = nil
    }

    
    func testCharacterUseCase_returnsExpectedCharacters() {
        // Given
        let expectation = expectation(description: "Should return characters succesfully")
        // When
        mockUsecase.getCharacters { result in
            // Then
            switch result {
            case .success(let characters):
                XCTAssertEqual(characters.count, 2)
                expectation.fulfill()
            case .failure(_):
                XCTFail("Expected success but got failure with error.")
            }
        }
        wait(for: [expectation], timeout: 2)
    }
    
}
