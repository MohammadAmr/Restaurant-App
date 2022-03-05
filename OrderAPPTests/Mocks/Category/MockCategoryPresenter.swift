//
//  MockCategoryPresenter.swift
//  OrderAPPTests
//
//  Created by Mohamed Adel on 3/5/22.
//  Copyright © 2022 Mohamed AMR. All rights reserved.
//

import Foundation
@testable import OrderAPP

class MockCategoryPresenter: CategoryPresenterProtocol {
    
    var networkManager: MockNetworkManager = MockNetworkManager(fileName: "Categories")
    var categories: [String] = []
    
    
    
    func fetchCategoryData() {
        networkManager.fetchCategories { [weak self] (result:Result<CategoriesResponse, Error>) in
           switch result {
           case .success(let categories):
               self?.categories = categories.categories
           case .failure(let error):
                print(error.localizedDescription)
           }
       }
    }    
    func getCategoriesCount() -> Int {
        categories.count
    }
    func getCatgoryAt(index: Int) -> String {
        return index < categories.count ? categories[index] : ""
    }
}

