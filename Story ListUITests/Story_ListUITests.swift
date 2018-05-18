//
//  Story_ListUITests.swift
//  Story ListUITests
//
//  Created by Raluca on 14/05/2018.
//  Copyright © 2018 Raluca. All rights reserved.
//

import XCTest

class Story_ListUITests: XCTestCase {
    var app : XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
    }
    
    func testInputIsCorrectForCreatingTheToDo() {
        app.launch()
        
        let textField = app.textFields.element
        XCTAssertTrue(textField.exists, "Text field doesn't exist")
        textField.tap()
        textField.typeText("newToDo")
        XCTAssertEqual(textField.value as! String, "newToDo", "Text field value is correct")
        
        let button = app.buttons["Done"]
        XCTAssertTrue(button.exists)
        button.tap()
        
        let table = app.tables.element
        XCTAssertTrue(table.exists)
        
        let cell = table.cells.element(boundBy: (table.cells.count - 1))
        XCTAssertTrue(cell.exists)
        
        let cellLabelText = cell.staticTexts.element(boundBy: 0).label
        XCTAssertEqual(cellLabelText, "newToDo")
        cell.staticTexts.element(boundBy: 0).tap()
    }
}
