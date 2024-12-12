//
//  uikitChallengeUITests.swift
//  uikitChallengeUITests
//
//  Created by Daniel Belmonte Valero on 12/12/24.
//

import XCTest

final class uikitChallengeUITests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testMainScreen() throws {
        let app = XCUIApplication()
        app.launchArguments = ["UITests_MainScreen"]
        app.launch()

        let table = app.tables["MainTable"]
        XCTAssertTrue(table.exists, "La tabla no extiste")
        XCTAssertGreaterThan(table.cells.count, 0, "Deberia haber una celda en la tabla")
    }

}
