//
//  OrderConfiarmPresenter.swift
//  OrderAPP
//
//  Created by Mohamed AMR on 2/25/22.
//  Copyright © 2022 Mohamed AMR. All rights reserved.
//

import Foundation

protocol OrderConfirmationPresenterProtocol
{
    func getTotalMinutes()->Int
    func setView(view: OrderCofiarmViewProtocol)
}
class OrderConfirmationPresenter{
    var view:OrderCofiarmViewProtocol?
    var totalMinutes : Int = 0
    init(totalMinutes: Int)
    {
        self.totalMinutes = totalMinutes
    }
    func setView(view: OrderCofiarmViewProtocol) {
           self.view = view
       }
}
extension OrderConfirmationPresenter : OrderConfirmationPresenterProtocol
{
    func getTotalMinutes() -> Int {
            totalMinutes
    }
    
    
}
