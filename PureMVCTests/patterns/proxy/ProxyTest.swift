//
//  ProxyTest.swift
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

import XCTest

final class ProxyTest: XCTestCase {

    func testNameAccessor() {
        // Create a new Proxy and use accessors to set the proxy name
        let proxy = Proxy.withName("TestProxy")
        
        // Test assertions
        XCTAssertNotNil(proxy, "Expecting proxy not to be nil")
        XCTAssertEqual(proxy.name, "TestProxy", "Expecting proxy.name == 'TestProxy'")
    }
    
    func testDataAccessor() {
        // Create a new Proxy and set the data
        let proxy = Proxy.withName("colors")
        proxy.data = ["red", "green", "blue"] as NSArray
        
        guard let data = proxy.data as? [String] else {
            XCTFail("Data is not of expected type [String]")
            return
        }

        // Test assertions
        XCTAssertNotNil(proxy, "Expecting proxy not to be nil")
        XCTAssertEqual(data.count, 3, "Expecting data.count == 3")
        XCTAssertEqual(data[0], "red", "Expecting data[0] == 'red'")
        XCTAssertEqual(data[1], "green", "Expecting data[1] == 'green'")
        XCTAssertEqual(data[2], "blue", "Expecting data[2] == 'blue'")
    }
    
    func testConstructor() {
        // Create a new Proxy using the constructor to set the name and data
        let proxy = Proxy.withName("colors", data: ["red", "green", "blue"] as NSArray)
        
        guard let data = proxy.data as? [String] else {
            XCTFail("Data is not of expected type [String]")
            return
        }

        // Test assertions
        XCTAssertNotNil(proxy, "Expecting proxy not to be nil")
        XCTAssertEqual(proxy.name, "colors", "Expecting proxy.name == 'colors'")
        XCTAssertNotNil(data, "Expecting data not to be nil")
        XCTAssertEqual(data.count, 3, "Expecting data.count == 3")
        XCTAssertEqual(data[0], "red", "Expecting data[0] == 'red'")
        XCTAssertEqual(data[1], "green", "Expecting data[1] == 'green'")
        XCTAssertEqual(data[2], "blue", "Expecting data[2] == 'blue'")
    }

}
