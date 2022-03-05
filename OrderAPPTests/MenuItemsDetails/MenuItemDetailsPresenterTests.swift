import XCTest

@testable import OrderAPP

class MenuItemDetailsPresenterTests: XCTestCase {
    private var sut: MenuItemDetailsPresenter!
    private var itemDetailsView: MockItemDetailsView!
    
    override func setUp() {
        super.setUp()
        itemDetailsView = MockItemDetailsView()
        sut = MenuItemDetailsPresenter(menuItem: MenuItem(id: 0, name: "Spaghetti and Meatballs", detailText: "Seasoned meatballs on top of freshly-made spaghetti. Served with a robust tomato sauce.", price: 9.0, category: "entrees", imageURL: URL(fileURLWithPath: "")))
    }
    
    override func tearDown() {
        sut = nil
        itemDetailsView = nil
        
        super.tearDown()
    }
    
    func testSut_whenInitCalled_menuItemIsSet() {
        
        XCTAssertNotNil(sut.menuItem)
    }
    
    func testSut_whenGetMenuItemCalled_menuItemIsReturned() {
       
        XCTAssertNotNil(sut.getMenuItem())
    }
    
    func testSut_whenViewIsSet_viewIsNotNil() {
        
        sut.setView(view: itemDetailsView)
        XCTAssertNotNil(sut.view)
    }
    
    func testSut_whengetCategoryCalled_categoryReturnCorrectValue() {
        
        
        XCTAssertNotEqual(sut.getCategory(), "")

    }
    
    func testSut_whengetNameCalled_nameReturnCorrectValue() {
        
        
        XCTAssertNotEqual(sut.getName(), "")

    }
    func testSut_whengetIDCalled_IDReturnCorrectValue() {
        
        
        XCTAssertEqual(sut.getID(), 0)

    }
    func testSut_whengetDescriptionCalled_descriptionReturnCorrectValue() {
        
        
        XCTAssertNotEqual(sut.getDescription(), "")

    }
    func testSut_whengetPriceCalled_priceReturnCorrectValue() {
        
        
        XCTAssertEqual(sut.getPrice(), 9.0)

    }
}
