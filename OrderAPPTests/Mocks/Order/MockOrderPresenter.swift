//
//  MockOrderPresenter.swift
//  OrderAPPTests
//
//  Created by Mohamed Adel on 3/5/22.
//  Copyright © 2022 Mohamed AMR. All rights reserved.
//
import Foundation
@testable import OrderAPP

class MockOrderPresenter: OrderPresenterProtocol {
    
    
    var orders: [MenuItem] = []
    var totalMinutes : Int = 0
    var networkManager: MockNetworkManager = MockNetworkManager(fileName: "Orders")
    
    
    func getOrderItemsCount() -> Int {
        orders.count
    }
    
    func getOrderItemAt(index: Int) -> MenuItem {
        orders[index]
    }
    
    func deleteOrderItemAt(index: Int) {
        orders.remove(at: index)
        
    }
    
    func getTotalPrice() -> Double {
        var total : Double = 0
        for menuItem in orders
        {
            total += menuItem.price
        }
        return total
    }
    
    func uploadOrder() {
        networkManager.submitOrder(forMenuIDs: [0])
           { (result) in
            switch result {
            case .success(let minutesToPrepare):
                //DispatchQueue.main.async {
                    self.totalMinutes = minutesToPrepare
               // }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getTotalMinutes() -> Int {
        totalMinutes
    }
    
}

