//
//  OrderPresenterTests.swift
//  OrderAPPTests
//
//  Created by Mohamed Adel on 3/5/22.
//  Copyright © 2022 Mohamed AMR. All rights reserved.
//

import XCTest
@testable import OrderAPP

class OrderPresenterTests: XCTestCase {
    private var sut : OrderPresenter!
    private var orderView : MockOrderView!
    let mockNetworkManager : MockNetworkManager = MockNetworkManager(fileName: "Orders")
    override func setUp() {
        super.setUp()
        orderView = MockOrderView()
        
        sut = OrderPresenter(mockNetworkManager, view: orderView)
        MenuController.shared.order.menuItems.append(MenuItem(id: 0, name: "Spaghetti and Meatballs", detailText: "Seasoned meatballs on top of freshly-made spaghetti. Served with a robust tomato sauce.", price: 9.0, category: "entrees", imageURL: URL(fileURLWithPath: "")))
    }

    override func tearDown() {
        sut = nil
        orderView = nil
        super.tearDown()
    }

   func testsut_whengetOrderItemsCount(){
        
        XCTAssertNotEqual(sut.getOrderItemsCount(),0)
    
    }
    
    
    func testSut_whenInitCalled_orderViewIsSet() {
        
        // Then
        XCTAssertNotNil(sut.view)
    }
    
    func testSut_when_getOrderItemAt() {
        
        
        XCTAssertNotNil(sut.getOrderItemAt(index: 0))
        
    }
    func testSut_when_deleteOrderItemAt() {
        
        
        MenuController.shared.order.menuItems.remove(at: 0)
        XCTAssertEqual(sut.getOrderItemsCount() , 0)
        
    }
    func testSut_when_getTotalPrice() {
        
        
        XCTAssertNotEqual(sut.getTotalPrice(),0)
        
    }
//    func testSut_when_uploadOrder() {
//
//        //when
//
//
//        XCTAssertNotNil(sut.getOrderItemAt(index: 0))
//
//    }
    func testSut_when_getTotalMinutes() {
        
        
        XCTAssertEqual(sut.getTotalMinutes(), 0)
        
    }
    
}
