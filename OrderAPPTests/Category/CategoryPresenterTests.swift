import XCTest

@testable import OrderAPP

class CategoryPresenterTests: XCTestCase {
    private var sut: CategoryPresenter!
    private var categoryView: MockCategoryView!
    
    override func setUp() {
        super.setUp()
        categoryView = MockCategoryView()
        sut = CategoryPresenter(MockNetworkManager(fileName: "Categories"), view: categoryView)
    }
    
    override func tearDown() {
        sut = nil
        categoryView = nil
        
        super.tearDown()
    }
    
    func testSut_whenInitCalled_categoryViewIsSet() {
        
        // Then
        XCTAssertNotNil(sut.view)
    }
    
    func testSut_whenGetCategoriesCalled_categoriesAreFilled() {
                
        // When
        print(sut.categories.count)
        sut.fetchCategoryData()
        print(sut.categories.count)
        // Then
        XCTAssertNotEqual(sut.categories, [])
    }
    
    func testSut_whengetCategoryAtIndexCalled_correctCategoryIsReturned() {
        
        // Given
        sut.fetchCategoryData()
        
        // When
        let firstCategory = sut.getCatgoryAt(index: 0)
        
        // Then
        XCTAssertEqual(firstCategory, "Desserts")
    }
    
    func testSut_whengetCategoryCountCalled_correctCategoryIsReturned() {
        
        // Given
        sut.fetchCategoryData()
        
        // When
        let categoryListCount = sut.getCategoriesCount()
        
        // Then
        XCTAssertEqual(categoryListCount, 3)

    }
    
    func testSut_whenGetCategoriesCalledWithFailure_categoriesStillEmpty() {
        // Given
        sut = CategoryPresenter(MockNetworkManager(fileName: "Error"), view: categoryView)
        
        // Then
        sut.fetchCategoryData()
        
        // Then
        XCTAssertEqual(sut.categories, [])

    }
}
