//
//  OrderCofiarmViewController.swift
//  OrderAPP
//
//  Created by Mohamed AMR on 2/25/22.
//  Copyright © 2022 Mohamed AMR. All rights reserved.
//

import UIKit
protocol OrderCofiarmViewProtocol {
    
}
class OrderCofiarmViewController: UIViewController, OrderCofiarmViewProtocol {
    @IBOutlet weak var totalMinutes: UILabel!
    var presenter : OrderConfirmationPresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        totalMinutes.text = "\(self.presenter?.getTotalMinutes() ?? 0)"
        // Do any additional setup after loading the view.
    }
    init?(coder : NSCoder, presenter: OrderConfirmationPresenterProtocol) {
        super.init(coder: coder)
        self.presenter = presenter
          self.presenter?.setView(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
