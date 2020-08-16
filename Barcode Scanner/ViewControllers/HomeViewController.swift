//
//  HomeViewController.swift
//  Barcode Scanner
//
//  Created by Prakhar Tripathi on 16/08/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyCartView: UIView!
    @IBOutlet weak var scanProductButton: UIButton!
    
    var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        refreshView()
    }
    
    @IBAction func scanProductButtonAction(_ sender: Any) {
    }
    
    func setupViews() {
        self.tableView.tableFooterView = UIView()
    }
    
    func refreshView() {
        if products.count > 0 {
            emptyCartView.isHidden = true
            tableView.isHidden = false
        } else {
            emptyCartView.isHidden = false
            tableView.isHidden = true
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProductsTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell")! as! ProductsTableViewCell
        cell.setValues(product: products[indexPath.row])
        return cell
    }
}
