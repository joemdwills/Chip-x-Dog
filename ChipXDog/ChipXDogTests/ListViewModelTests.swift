//
//  ListViewModelTests.swift
//  ChipXDogTests
//
//  Created by Joe on 05/06/2022.
//

import XCTest
@testable import ChipXDog

class ListViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDecodeSuccessful() throws {
        let viewModel = ListViewModel()
        let data = MockData()
        viewModel.decodeResponse(data: data.goodJSON)
        XCTAssertEqual(viewModel.dogs.count > 10, true)
    }
    
    func testDecodeIsUnSuccessful() throws {
        let viewModel = ListViewModel()
        let data = MockData()
        viewModel.decodeResponse(data: data.badJSON)
        XCTAssertEqual(viewModel.dogs.count > 10, false)
    }
}
