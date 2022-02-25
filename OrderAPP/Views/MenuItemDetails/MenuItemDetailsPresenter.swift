//
//  MenuItemDetailsPresenter.swift
//  OrderAPP
//
//  Created by Mohamed AMR on 2/25/22.
//  Copyright © 2022 Mohamed AMR. All rights reserved.
//

import Foundation
protocol MenuItemDetailsPresenterProtocol {
    func setView(view: MenuItemDetailsViewProtocol)
    func getImageURL() -> Data
    func getName() -> String
    func getPrice() -> Double
    func getDescription() -> String
    func getID() -> Int
    func getCategory() -> String
    func getMenuItem() -> MenuItem
    
}
class MenuItemDetailsPresenter
{
    weak var view : MenuItemDetailsViewProtocol?
    let menuItem : MenuItem
    
    
    init(menuItem: MenuItem)
    {
        self.menuItem = menuItem
    }
}
extension MenuItemDetailsPresenter : MenuItemDetailsPresenterProtocol
{
    func getMenuItem() -> MenuItem {
        menuItem
    }
    
    func getCategory() -> String {
        menuItem.category
    }
    
    func getImageURL() -> Data {
        var data:Data!
        do{
            data = try Data(contentsOf: menuItem.imageURL)
            return data
        }
        catch
        {
            print("Unexpected non-vending-machine-related error: \(error)")
        }
        return data
    }
    
    func getName() -> String {
        menuItem.name
    }
    
    func getPrice() -> Double {
        menuItem.price
    }
    
    func getDescription() -> String {
        menuItem.detailText
    }
    
    func getID() -> Int {
        menuItem.id
    }
    func setView(view: MenuItemDetailsViewProtocol) {
        self.view = view
    }
    
}
