//
//  MenuItemDetailsViewController.swift
//  OrderAPP
//
//  Created by Mohamed AMR on 2/25/22.
//  Copyright © 2022 Mohamed AMR. All rights reserved.
//

import UIKit
protocol MenuItemDetailsViewProtocol : AnyObject {
    
}
class MenuItemDetailsViewController: UIViewController, MenuItemDetailsViewProtocol {

    var presenter : MenuItemDetailsPresenterProtocol?
    
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemDetail: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var addToOrderButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addToOrderButton.layer.cornerRadius = 5.0
        configureUI()
        // Do any additional setup after loading the view.
    }
    init?(coder: NSCoder, presenter: MenuItemDetailsPresenterProtocol) {
        super.init(coder: coder)
        self.presenter = presenter
        self.presenter?.setView(view: self)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @IBAction func orderButtonTapped(_ sender: UIButton) {
            UIView.animate(withDuration: 0.5, delay: 0,
               usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1,
               options: [], animations: {
                self.addToOrderButton.transform =
                   CGAffineTransform(scaleX: 2.0, y: 2.0)
                self.addToOrderButton.transform =
                   CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: nil)
        guard let menuItem = self.presenter?.getMenuItem() else
        {
            return
        }
        MenuController.shared.order.menuItems.append(menuItem)
        
    }
    func configureUI()
    {
        self.navigationItem.title = self.presenter?.getCategory().capitalized
        addToOrderButton.layer.cornerRadius = 25;
        itemName.text   = self.presenter?.getName()
        itemPrice.text  = MenuItem.priceFormatter.string(from: NSNumber(value: self.presenter?.getPrice() ?? 0))
        itemDetail.text = self.presenter?.getDescription()
        //let menuItem = self.presenter?.getMenuItem()
        /*MenuController.fetchImage(url: menuItem?.imageURL
               { (image) in
                guard let image = image else { return }
                DispatchQueue.main.async {
                    self.itemImage.image = image
                }
            }*/
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
