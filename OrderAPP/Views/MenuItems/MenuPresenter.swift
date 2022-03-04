//
//  MenuPresenter.swift
//  OrderAPP
//
//  Created by Mohamed AMR on 2/25/22.
//  Copyright © 2022 Mohamed AMR. All rights reserved.
//

import Foundation
protocol MenuPresenterProtocol {
    func setView(view: MenuViewProtocol)
    func fetchMenuItems()
    func getMenuItemsCount() -> Int
    func getMenuItemAt(index: Int) -> MenuItem
    func getCategory() -> String
}
class MenuPresenter
{
    weak var view : MenuViewProtocol?
    var menuItems = [MenuItem]()
    let category : String
    var networkManager : networkService
    
    
    init(_ networkManager: networkService = MenuController.shared, category: String)
    {
        self.category = category
        self.networkManager = networkManager
        fetchMenuItems()
    }
}
extension MenuPresenter : MenuPresenterProtocol
{
    
    
    
    func fetchMenuItems() {
        
        networkManager.fetchMenuItems(forCategory: category) { [weak self](result:Result<MenuResponse, Error>) in
            switch result {
            case .success(let menuItems):
                DispatchQueue.main.async {
                    self?.menuItems = menuItems.items
                    self?.view?.reloadTable()
            }
            case .failure(let error):
                print(error)
                self?.view?.displayError(error,
                title: "Failed to Fetch Categories")
            }
        }
    }
    
    func getMenuItemsCount() -> Int {
        return menuItems.count
    }
    
    func getMenuItemAt(index: Int) -> MenuItem {
        return menuItems[index]
    }
    
    func setView(view: MenuViewProtocol) {
        self.view = view
    }
    func getCategory() -> String {
        return self.category
    }
    
}
