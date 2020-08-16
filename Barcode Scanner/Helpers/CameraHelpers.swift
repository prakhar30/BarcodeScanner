//
//  CameraHelpers.swift
//  Barcode Scanner
//
//  Created by Prakhar Tripathi on 16/08/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit
protocol ProductScanned: class {
    func produceScanned(id: String)
}

class CameraHelper: NSObject, AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ captureOutput: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        // Get the metadata object.
        guard let metadataObj = metadataObjects.first as? AVMetadataMachineReadableCodeObject else {
            return
        }
        
        if supportedCodeTypes.contains(metadataObj.type) {
            if metadataObj.stringValue != nil {
                captureSession?.stopRunning()
                self.delegate?.produceScanned(id: metadataObj.stringValue ?? "")
            }
        }
    }

    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    let supportedCodeTypes = [AVMetadataObject.ObjectType.upce,
                              AVMetadataObject.ObjectType.code39,
                              AVMetadataObject.ObjectType.code39Mod43,
                              AVMetadataObject.ObjectType.code93,
                              AVMetadataObject.ObjectType.code128,
                              AVMetadataObject.ObjectType.ean8,
                              AVMetadataObject.ObjectType.ean13,
                              AVMetadataObject.ObjectType.aztec,
                              AVMetadataObject.ObjectType.pdf417,
                              AVMetadataObject.ObjectType.qr,
                              AVMetadataObject.ObjectType.itf14,
                              AVMetadataObject.ObjectType.interleaved2of5,
                              AVMetadataObject.ObjectType.dataMatrix]
    
    weak var delegate: ProductScanned?
    
    func loadCamera(cameraView: UIView) {
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {
            return
        }

        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // Initialize the captureSession object.
            captureSession = AVCaptureSession()
            
            // Set the input device on the capture session.
            captureSession?.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
            
            // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoPreviewLayer?.videoGravity = .resizeAspectFill
            DispatchQueue.main.async {
                self.videoPreviewLayer?.frame = cameraView.layer.bounds
                cameraView.layer.addSublayer(self.videoPreviewLayer!)
                // Start video capture.
                self.captureSession?.startRunning()
            }
            
            NotificationCenter.default.addObserver(self, selector: #selector(willResignActive), name: UIApplication.willResignActiveNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(openedAgain), name: UIApplication.didBecomeActiveNotification, object: nil)
        } catch {
            print("Camera setup error " + error.localizedDescription)
            return
        }
    }
    
    @objc func openedAgain() {
        captureSession?.startRunning()
    }
    
    @objc func willResignActive() {
        captureSession?.stopRunning()
    }
}
