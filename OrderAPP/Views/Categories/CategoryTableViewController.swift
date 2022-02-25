//
//  CategoryTableViewController.swift
//  OrderAPP
//
//  Created by Mohamed AMR on 2/25/22.
//  Copyright © 2022 Mohamed AMR. All rights reserved.
//

import UIKit
protocol CategoryViewProtocol: AnyObject {
    func reloadTable()
    func displayError(_ error: Error, title: String)
}

class CategoryTableViewController: UITableViewController {
    
    var presenter : CategoryPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = CategoryPresenter(view:self)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    //    @IBSegueAction func showMenu(_ coder: NSCoder, sender: Any?) -> MenuTableViewController? {
    //        guard let cell = sender as? UITableViewCell, let indexPath =
    //               tableView.indexPath(for: cell) else {
    //                return nil
    //            }
    //
    //             let category = self.presenter?.getCatgoryAt(index: indexPath.row) ?? "M3lsh"
    //             let presenter = MenuPresenter(category: category)
    //             return MenuTableViewController(coder: coder, presenter: presenter)
    //    }
    @IBSegueAction func showMenu(_ coder: NSCoder, sender: Any?) -> MenuTableViewController? {
        guard let cell = sender as? UITableViewCell, let indexPath =
            tableView.indexPath(for: cell) else {
                return nil
        }
        
        let category = self.presenter?.getCatgoryAt(index: indexPath.row) ?? "M3lsh"
        let presenter = MenuPresenter(category: category)
        let vc = MenuTableViewController(coder: coder, presenter: presenter)
        presenter.view = vc
        return vc
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return presenter?.getCategoriesCount() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt
        indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
            "Category", for: indexPath)
        configureCell(cell, forCategoryAt: indexPath)
        return cell
    }
    
    func configureCell(_ cell: UITableViewCell, forCategoryAt
        indexPath: IndexPath) {
        let category = presenter?.getCatgoryAt(index: indexPath.row)
        cell.textLabel?.text = category?.capitalized
    }
}

extension CategoryTableViewController : CategoryViewProtocol
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.size.height/8
    }
    
}
