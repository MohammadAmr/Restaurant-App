//
//  MockCategoryView.swift
//  OrderAPPTests
//
//  Created by Mohamed AMR on 3/4/22.
//  Copyright © 2022 Mohamed AMR. All rights reserved.
//

import XCTest
@testable import OrderAPP

class MockCategoryView : CategoryViewProtocol {
    var isTableReloaded = false
    func reloadTable() {
        isTableReloaded = true
    }
    
    func displayError(_ error: Error, title: String) {
        print(error.localizedDescription)
    }
    
    
    
}
