//
//  CatgoryPresenter.swift
//  OrderAPP
//
//  Created by Mohamed AMR on 2/25/22.
//  Copyright © 2022 Mohamed AMR. All rights reserved.
//

import Foundation
protocol CategoryPresenterProtocol : AnyObject{
    func fetchCategoryData()
    func getCategoriesCount() -> Int
    func getCatgoryAt(index: Int) -> String
}

class CategoryPresenter{
    
    weak var view : CategoryViewProtocol?
    var categories = [String]()
    
    init(view:CategoryViewProtocol) {
        self.view = view
        fetchCategoryData()
        print(categories.count)
    }
    
    
    
    
    
}

extension CategoryPresenter : CategoryPresenterProtocol
{
    func getCategoriesCount() -> Int {
        categories.count
    }
    
    func getCatgoryAt(index: Int) -> String {
        return categories[index]
    }
    
    func fetchCategoryData() {
        
        MenuController.shared.fetchCategories { (result) in
            switch result {
            case .success(let categories):
                DispatchQueue.main.async {
                    self.categories = categories
                    self.view?.reloadTable()
                }
            case .failure(let error):
                print(error)
                self.view?.displayError(error,
                title: "Failed to Fetch Categories")
            }
        }
                
    }
    
    
}
