//
//  MockOrderView.swift
//  OrderAPPTests
//
//  Created by Mohamed Adel on 3/5/22.
//  Copyright © 2022 Mohamed AMR. All rights reserved.
//
import XCTest
@testable import OrderAPP

class MockOrderView : OrderViewProtocol {
    var isTableReloaded = false
    func reloadTable() {
        isTableReloaded = true
    }
    
    func displayError(_ error: Error, title: String) {
        print(error.localizedDescription)
    }
    
}
