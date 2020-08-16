//
//  HomeViewController.swift
//  Barcode Scanner
//
//  Created by Prakhar Tripathi on 16/08/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit
protocol ProductScannedSuccess: class {
    func productScanned(product: Product)
    func wrongProductScanned()
}

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyCartView: UIView!
    @IBOutlet weak var scanProductButton: UIButton!
    
    var products = [Product]() {
        didSet {
            self.refreshView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        refreshView()
    }
    
    @IBAction func scanProductButtonAction(_ sender: Any) {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let cameraVC = storyboard.instantiateViewController(withIdentifier: "CameraViewController_ID") as! CameraViewController
            cameraVC.delegate = self
            self.present(cameraVC, animated: true, completion: nil)
        }
    }
    
    func setupViews() {
        self.tableView.tableFooterView = UIView()
    }
    
    func refreshView() {
        if products.count > 0 {
            emptyCartView.isHidden = true
            tableView.isHidden = false
            tableView.reloadData()
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

extension HomeViewController: ProductScannedSuccess {
    func wrongProductScanned() {
        let alert = UIAlertController(title: "Wrong Code Scanned", message: "Please try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func productScanned(product: Product) {
        self.products.append(product)
    }
}
