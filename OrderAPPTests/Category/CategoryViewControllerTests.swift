//
//  CategoryViewControllerTests.swift
//  OrderAPPTests
//
//  Created by Mohamed AMR on 2/26/22.
//  Copyright © 2022 Mohamed AMR. All rights reserved.
//
/*
import XCTest
@testable import OrderAPP

class CategoryViewControllerTests: XCTestCase {
    private var sut: CategoryViewController!
    
    override func setUp() {
        super.setUp()
        sut = CategoryViewController()
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    func testSUT_ShouldSetTableViewDelegate() {
      
      XCTAssertNotNil(sut.tableView.delegate)
    }
    
    func testSUT_ShouldSetTableViewDatasource() {
      
      XCTAssertNotNil(sut.tableView.dataSource)
    }
    
    func testSut_whenViewDidLoadCalled_categoryPresenterIsSet() {
        // When
        sut.loadViewIfNeeded()
        
        // Then
        XCTAssertNotNil(sut.presenter)
    }
    
    func testSut_startsWithEmptyTableView() {
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }
    
    func testSut_whenGetCategoriesAndReloadTableIsCalled_tableViewIsFilled() {
        let presenter = MockCategoryPresenter()
        sut.presenter = presenter
        sut.loadViewIfNeeded()
        sut.reloadTableView()
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), presenter.categories.count)
    }
    
    func testSut_whenCellForRowIsCalled_cellIsReturnedWithCorrectData() {
        // Given
        
        // To register the cell with the table view
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "CategoryViewController") as? CategoryViewController
        
        sut.presenter = MockCategoryPresenter()
        sut.presenter.getCategories()

        
        // When
        let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        
        // Then
        XCTAssertEqual(cell.textLabel?.text, "Desserts")
    }
    
    func testSut_whenSeguePerformed_MenuTableViewControllerIsPresented(){
        // To register the cell with the table view
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "CategoryViewController") as? CategoryViewController
        sut.presenter = MockCategoryPresenter()
        let window = UIWindow()
       
        window.rootViewController = UINavigationController(rootViewController: sut)
        sut.loadViewIfNeeded()
        
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))

        sut.performSegue(withIdentifier: "CategoryToMenuItemsSegue", sender: cell)
        RunLoop.current.run(until: Date())
        XCTAssertNotNil(sut.navigationController?.topViewController as? MenuuTableViewController)
    }
}

class MockCategoryPresenter: CategoryPresenterProtocol {
    var networkManager: NetworkingProtocol = MockNetworkManager(fileName: "")
    var categories: [String] = []
    func getCategories() {
        categories = ["Desserts", "Sides"]
    }
    
    func getCategory(index: Int) -> String {
        return index < categories.count ? categories[index] : ""
    }
    
    func getCount() -> Int {
        categories.count
    }
}
*/
