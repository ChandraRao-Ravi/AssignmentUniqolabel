//
//  QRCodeViewController.swift
//  DemoApp
//
//  Created by Chandra Rao on 12/11/17.
//  Copyright © 2017 Chandra Rao. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class QRCodeViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    @IBOutlet weak var viewShowPreview: UIView!
    @IBOutlet weak var lblPreviewStatus: UILabel!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var txtViewQRValues: UITextView!
    var captureSession : AVCaptureSession? = nil
    var videoPreviewLyr : AVCaptureVideoPreviewLayer? = nil
    
    var isReading : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnStartClikced(_ sender: Any) {
        if !isReading {
            if startReading() {
                btnStart.setTitle("Stop", for: UIControlState.normal)
            }
        } else {
            stopReading()
            btnStart.setTitle("Start Scanning", for: UIControlState.normal)
        }
        
    }
    
    func startReading() -> Bool {
        
        let captureDevice : AVCaptureDevice = AVCaptureDevice.default(for: AVMediaType.video)!
        
        do {
            let deviceInput : AVCaptureDeviceInput = try AVCaptureDeviceInput.init(device: captureDevice)
            captureSession = AVCaptureSession.init()
            captureSession?.addInput(deviceInput)
            
            let captureMetaOutput : AVCaptureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetaOutput)
            
            var dispatchQueue: DispatchQueue?
            dispatchQueue = DispatchQueue(label: "myQueue")
            captureMetaOutput.setMetadataObjectsDelegate(self, queue: dispatchQueue)
            captureMetaOutput.metadataObjectTypes = [.qr]
            
            videoPreviewLyr = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoPreviewLyr?.videoGravity = .resizeAspectFill
            videoPreviewLyr?.frame = viewShowPreview.layer.bounds
            viewShowPreview.layer.addSublayer(videoPreviewLyr!)
            
            captureSession?.startRunning()
        } catch  {
          print(error.localizedDescription)
        }
        
        
        return true
    }
    
    @objc func stopReading()  {
        captureSession?.stopRunning()
        
        videoPreviewLyr?.removeFromSuperlayer()
        
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects != nil && metadataObjects.count > 0 {
            let metadataObj: AVMetadataMachineReadableCodeObject? = metadataObjects[0] as? AVMetadataMachineReadableCodeObject
            if (metadataObj?.type == .qr) {
                
                DispatchQueue.main.async {
                    self.txtViewQRValues.text = metadataObjects.description
//                   print(metadataObj!)
                    self.captureSession?.stopRunning()
                }

                isReading = false
                
            }

        }
    }
    
    func showAlert(withTitleAndMessage title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
