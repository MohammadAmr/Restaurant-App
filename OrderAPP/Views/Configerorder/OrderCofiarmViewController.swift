//
//  OrderCofiarmViewController.swift
//  OrderAPP
//
//  Created by Mohamed AMR on 2/25/22.
//  Copyright © 2022 Mohamed AMR. All rights reserved.
//

import UIKit
protocol OrderCofiarmViewProtocol {
    func setPresenter(presenter: OrderConfirmationPresenterProtocol)
    
}
class OrderCofiarmViewController: UIViewController {
    @IBOutlet weak var totalMinutes: UILabel!
    var presenter : OrderConfirmationPresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        totalMinutes.text = "\(self.presenter?.getTotalMinutes() ?? 0)"
        // Do any additional setup after loading the view.
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
extension OrderCofiarmViewController : OrderCofiarmViewProtocol
{
    func setPresenter(presenter: OrderConfirmationPresenterProtocol)
    {
        self.presenter = presenter
    }
}
