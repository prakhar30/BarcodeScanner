//
//  CameraViewController.swift
//  Barcode Scanner
//
//  Created by Prakhar Tripathi on 16/08/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {

    @IBOutlet weak var cameraView: UIView!
    var cameraHelpers: CameraHelper?
    weak var delegate: ProductScannedSuccess?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        getCameraPermission { (result) in
            if result {
                self.cameraHelpers = CameraHelper()
                self.cameraHelpers?.delegate = self
                self.cameraHelpers?.loadCamera(cameraView: self.cameraView)
            }
        }
    }
    
    func getCameraPermission(completionHandler: @escaping (Bool) -> Void) {
        AVCaptureDevice.requestAccess(for: .video) { (result) in
            completionHandler(result)
        }
    }
}

extension CameraViewController: ProductScanned {
    func produceScanned(id: String) {
        if let product = productsList[id] {
            let productValues = Product(id: id, image: product["image"]!, name: product["name"]!, price: product["price"]!)
            self.delegate?.productScanned(product: productValues)
            self.dismiss(animated: true, completion: nil)
            // display product added successfully.
        } else {
            // display incorrect product scanned
            self.dismiss(animated: true) {
                self.delegate?.wrongProductScanned()
            }
        }
    }
}
