//
//  HomeViewModelTests.swift
//  Game of Thrones ProjectTests
//
//  Created by Andy Heredia on 16/4/25.
//

import XCTest
@testable import Game_of_Thrones_Project

final class HomeViewModelTests: XCTestCase {
    
    var viewModel: HomeViewModel!
    var useCaseMock: CharacterUseCaseMock!
    var networkMock: CharacterNetworkMock!

    override func setUpWithError() throws {
        
       
      
        
        networkMock = CharacterNetworkMock(resultToReturn: .success([]))
        useCaseMock = CharacterUseCaseMock(repo: CharacterRepository(network: networkMock))
        viewModel = HomeViewModel(useCase: useCaseMock)
    }

    override func tearDownWithError() throws {
        networkMock = nil
        useCaseMock = nil
        viewModel = nil
    }

    func testHomeViewModel_success_shouldPopulateCharacters() throws {
        
     
        // Given
        viewModel.characters = [
            GOTResponse(
               id: 1,
               firstName: "Jon",
               lastName: "Snow",
               fullName: "Jon Snow",
               title: "King of the North",
               family: "House Stark",
               imageUrl: "https://thronesapi.com/assets/images/jon-snow.jpg"
           ),
            GOTResponse(
                id: 2,
                firstName: "Daenerys",
                lastName: "Targaryen",
                fullName: "Daenerys Targaryen",
                title: "Mother of Dragons",
                family: "House Targaryen",
                imageUrl: "https://thronesapi.com/assets/images/daenerys.jpg"
            )
        ]
        
        let expectation = expectation(description: "Characters Loaded")
        
        // When
        XCTAssertEqual(viewModel.characters.count, 2)
        expectation.fulfill()
        
        wait(for: [expectation], timeout: 2)
    }
    
 

}
