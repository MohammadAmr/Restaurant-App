//
//  OrderTableViewController.swift
//  OrderAPP
//
//  Created by Mohamed AMR on 2/25/22.
//  Copyright © 2022 Mohamed AMR. All rights reserved.
//

import UIKit
protocol OrderViewProtocol : AnyObject{
    func reloadTable()
    func displayError(_ error: Error, title: String)
}
class OrderTableViewController: UITableViewController{
    var presenter: OrderPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        self.presenter = OrderPresenter(view: self)
        NotificationCenter.default.addObserver(tableView!,
               selector: #selector(UITableView.reloadData),
               name: MenuController.orderUpdatedNotification, object: nil)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UIScreen.main.bounds.size.height / 8
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.presenter?.getOrderItemsCount() ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderItem", for: indexPath)

        configure(cell, forItemAt: indexPath)
        return cell
    }
    
    
    func configure(_ cell: UITableViewCell, forItemAt indexPath:
       IndexPath) {
        let menuItem = self.presenter?.getOrderItemAt(index: indexPath.row)
        cell.imageView?.image = UIImage(named: "food.jpg")
        cell.textLabel?.text = menuItem?.name
        cell.detailTextLabel?.text =
            MenuItem.priceFormatter.string(from: NSNumber(value:
           menuItem?.price ?? 0))
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            self.presenter?.deleteOrderItemAt(index: indexPath.row)
        }
    }
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func SubmitBtndidPressed(_ sender: Any) {
            let orderTotal =
               MenuController.shared.order.menuItems.reduce(0.0)
               { (result, menuItem) -> Double in
                return result + menuItem.price
            }
        
        let orderConfirmVC = self.storyboard?.instantiateViewController(identifier: "OrderCofiarmViewController") as! OrderCofiarmViewController
        
        let tmpPresenter : OrderConfirmationPresenterProtocol = OrderConfirmationPresenter(totalMinutes: self.presenter?.getTotalMinutes() ?? 0)
        
        orderConfirmVC.setPresenter(presenter: tmpPresenter)
        tmpPresenter.setView(view: orderConfirmVC)
        
        _ = MenuItem.priceFormatter.string(from: NSNumber(value: orderTotal)) ?? "\(orderTotal)"
        
        
        let alertController = UIAlertController(title:"Confirm Order", message: "You are about to submit your order with a total of \(orderTotal)",
           preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Submit",
           style: .default, handler: { _ in
            //self.presenter?.uploadOrder()
            self.navigationController?.pushViewController(orderConfirmVC, animated: true)
        }))
        alertController.addAction(UIAlertAction(title: "Cancel",
           style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func displayError(_ error: Error, title: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message:
               error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss",
               style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
extension OrderTableViewController : OrderViewProtocol
{
    func reloadTable()
    {
        self.tableView.reloadData()
    }
}
