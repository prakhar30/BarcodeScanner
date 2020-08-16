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
    
    var products = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        refreshView()
    }
    
    @IBAction func scanProductButtonAction(_ sender: Any) {
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
