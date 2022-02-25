//
//  OrderPresenter.swift
//  OrderAPP
//
//  Created by Mohamed AMR on 2/25/22.
//  Copyright © 2022 Mohamed AMR. All rights reserved.
//

import Foundation
protocol OrderPresenterProtocol {
    func getOrderItemsCount() -> Int
    func getOrderItemAt(index: Int) -> MenuItem
    func deleteOrderItemAt(index: Int)
    func getTotalPrice()->Double
    func uploadOrder()
    func getTotalMinutes()->Int
}
class OrderPresenter
{
    weak var view : OrderViewProtocol?
    var totalMinutes : Int = 0
    init(view: OrderViewProtocol)
    {
        self.view = view
        uploadOrder()
    }
}
extension OrderPresenter : OrderPresenterProtocol
{
    
    func getOrderItemsCount() -> Int {
        MenuController.shared.order.menuItems.count
    }
    
    func getOrderItemAt(index: Int) -> MenuItem {
        MenuController.shared.order.menuItems[index]
    }
    
    func deleteOrderItemAt(index: Int) {
        MenuController.shared.order.menuItems.remove(at: index)
        self.view?.reloadTable()
    }
    func getTotalPrice()->Double {
        var total : Double = 0
        for menuItem in MenuController.shared.order.menuItems
        {
            total += menuItem.price
        }
        return total
    }
    func uploadOrder() {
        let menuIds = MenuController.shared.order.menuItems.map{ $0.id }
        MenuController.shared.submitOrder(forMenuIDs: menuIds)
           { (result) in
            switch result {
            case .success(let minutesToPrepare):
                DispatchQueue.main.async {
                    self.totalMinutes = minutesToPrepare
                }
            case .failure(let error):
                self.view?.displayError(error, title: "Order Submission Failed")
            }
        }
    }
    func getTotalMinutes()->Int{
        totalMinutes
    }
    
    
}
