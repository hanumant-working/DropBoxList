//
//  DropBoxListTests.swift
//  DropBoxListTests
//
//  Created by Hanumant S on 29/01/18.
//  Copyright © 2018 Hanumant S. All rights reserved.
//

import XCTest
@testable import DropBoxList

class DropBoxListTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // Check file on local bundle or not
    func testFileLoadingFromBundle() throws {
        let bundle = Bundle(for: type(of: self))
        if let _ = bundle.url(forResource: "Fact", withExtension: "json") {
            XCTFail("Missing file: Fact.json")
            return
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
