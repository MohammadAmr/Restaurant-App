//
//CategoryViewControllerTests.swift
//OrderAPPTests
//
//Created by Mohamed AMR on 2/26/22.
//Copyright © 2022 Mohamed AMR. All rights reserved.


import XCTest
@testable import OrderAPP
import UIKit

class CategoryViewControllerTests: XCTestCase {
    private var sut: CategoryTableViewController!
    
    override func setUp() {
        super.setUp()
        sut = CategoryTableViewController()
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    //Our category controller is from tableview Controller
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
        //Given
        let presenter = MockCategoryPresenter()
        sut.presenter = presenter
        sut.loadViewIfNeeded()
        //When
        sut.reloadTable()
        //Then
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), presenter.categories.count)
    }
    
    /*func testSut_whenCellForRowIsCalled_cellIsReturnedWithCorrectData() {
        // Given
        
        // To register the cell with the table view
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "CategoryTableViewController") as? CategoryTableViewController
        
        sut.presenter = MockCategoryPresenter()
        sut.presenter?.fetchCategoryData()
        sut.loadViewIfNeeded()
        // When
        let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell.textLabel?.text ?? "", "Desserts")
    }
    
    
    func testSut_whenSeguePerformed_MenuTableViewControllerIsPresented(){
        // To register the cell with the table view
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "CategoryTableViewController") as? CategoryTableViewController
        
        // Then      sut.presenter = MockCategoryPresenter()
        let window = UIWindow()
        
        window.rootViewController = UINavigationController(rootViewController: sut)
        sut.loadViewIfNeeded()
        
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        
        
       sut.performSegue(withIdentifier: "CategoryToMenuItemsSegue", sender: cell)
        RunLoop.current.run(until: Date())
        
        XCTAssertNotNil(sut.navigationController?.topViewController as? MenuTableViewController)
    }*/
}
