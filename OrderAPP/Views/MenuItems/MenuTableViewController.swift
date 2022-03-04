//
//  MenuTableViewController.swift
//  OrderAPP
//
//  Created by Mohamed AMR on 2/25/22.
//  Copyright © 2022 Mohamed AMR. All rights reserved.
//

import UIKit
protocol MenuViewProtocol : AnyObject{
    func reloadTable()
    func displayError(_ error: Error, title: String)
}
class MenuTableViewController: UITableViewController {
    let priceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
     
        return formatter
    }()
    var presenter : MenuPresenterProtocol?
    init?(coder: NSCoder, presenter: MenuPresenterProtocol)
    {
        super.init(coder: coder)
        self.presenter = presenter
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.presenter?.getCategory().capitalized
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.presenter?.getMenuItemsCount() ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemCell", for: indexPath)
        configure(cell, forItemAt: indexPath)
        return cell
    }
    func configure(_ cell: UITableViewCell, forItemAt indexPath:
       IndexPath) {
        let menuItem = self.presenter?.getMenuItemAt(index: indexPath.row)
        cell.textLabel?.text = menuItem?.name
        cell.imageView?.image = UIImage(named: "food.jpg")
        cell.detailTextLabel?.text = MenuItem.priceFormatter.string(from: NSNumber(value: menuItem?.price ?? 0))
    }
    
    @IBSegueAction func showItemDetails(_ coder: NSCoder, sender: Any?) -> MenuItemDetailsViewController? {

        guard let cell = sender as? UITableViewCell, let indexPath =
            tableView.indexPath(for: cell) else {
                return nil
        }

        guard let menuItem = self.presenter?.getMenuItemAt(index: indexPath.row) else { return nil }
        let presenter = MenuItemDetailsPresenter(menuItem: menuItem)
        return MenuItemDetailsViewController(coder: coder, presenter: presenter)
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.size.height / 8
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
    

}
extension MenuTableViewController : MenuViewProtocol
{
    func reloadTable() {
        self.tableView.reloadData()
    }
    func displayError(_ error: Error, title: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title,
                                          message: error.localizedDescription,   preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss",
                                          style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
