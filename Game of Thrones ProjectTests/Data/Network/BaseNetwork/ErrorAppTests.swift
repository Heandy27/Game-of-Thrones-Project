//
//  ErrorAppTests.swift
//  Game of Thrones ProjectTests
//
//  Created by Andy Heredia on 16/4/25.
//

import XCTest
@testable import Game_of_Thrones_Project

final class ErrorAppTests: XCTestCase {
    
    
    func testErrorApp_WhenGivenGenericErros_ShouldBeEquals() {
        XCTAssertEqual(ErrorApp.badUrl, ErrorApp.badUrl)
        XCTAssertEqual(ErrorApp.errorParsingData, ErrorApp.errorParsingData)
        XCTAssertEqual(ErrorApp.noDataReceived, ErrorApp.noDataReceived)
        XCTAssertEqual(ErrorApp.requestWasNil, ErrorApp.requestWasNil)
    }
    
    func testErrorApp_errorFromApiEquality_ShouldBeEqual_WhenStatusCodeMatch() {
        //Given
        let error1 = ErrorApp.errorFromApi(statuscode: 404)
        let error2 = ErrorApp.errorFromApi(statuscode: 404)
        // Then
        XCTAssertEqual(error1, error2)
    }
    
    func testErrorApp_errorFromApiEquality_shouldNotBeEqual_whenStatusCodesDiffer() {
        // Given
        let error1 = ErrorApp.errorFromApi(statuscode: 500)
        let error2 = ErrorApp.errorFromApi(statuscode: 404)
        
        //Then
        XCTAssertNotEqual(error1, error2)
    }
    
    func testErrorApp_errorFromServer_ShouldBeEqual() {
        //Given
        let error1 = ErrorApp.errorFromServer(error: "Timeout")
        let error2 = ErrorApp.errorFromServer(error: "Timeout")
        //Then
        XCTAssertEqual(error1, error2)
    }
    
    
    func testErrorApp_characterNotFoundEquality_shouldBeEqual_whenIDsMatch() {
        // Given
        let error1 = ErrorApp.characterNotFound(idCharacter: 123)
        let error2 = ErrorApp.characterNotFound(idCharacter: 123)
        
        // Then
        XCTAssertEqual(error1, error2)
    }
    
    func testErrorApp_characterNotFoundEquality_shouldNotBeEqual_whenIDsDiffer() {
        // Given
        let error1 = ErrorApp.characterNotFound(idCharacter: 123)
        let error2 = ErrorApp.characterNotFound(idCharacter: 999)
        
        // Then
        XCTAssertNotEqual(error1, error2)
    }
    
    
}
