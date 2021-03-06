//
//  QRCodeViewController.swift
//  MacleanRH
//
//  Created by iem on 04/06/2015.
//  Copyright (c) 2015 iem. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {
    
    var objCaptureSession:AVCaptureSession?
    var objCaptureVideoPreviewLayer:AVCaptureVideoPreviewLayer?
    var vwQRCode:UIView?
    
    var isSanning:Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.isSanning = false
        
        
        self.configureVideoCapture()
        self.addVideoPreviewLayer()
        self.initializeQRView()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.isSanning = false
    }
    
    func configureVideoCapture()
    {
        let objCaptureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        var error:NSError?
        let objCaptureDeviceInput: AnyObject! = AVCaptureDeviceInput.deviceInputWithDevice(objCaptureDevice, error: &error)
        
        if (error != nil) {
            var alertView:UIAlertView = UIAlertView(title: "Device Error", message:"Device not Supported for this Application", delegate: nil, cancelButtonTitle: "Ok Done")
            alertView.show()
            return
        }
        
        objCaptureSession = AVCaptureSession()
        objCaptureSession?.addInput(objCaptureDeviceInput as! AVCaptureInput)
        
        let objCaptureMetadataOutput = AVCaptureMetadataOutput()
        objCaptureSession?.addOutput(objCaptureMetadataOutput)
        
        objCaptureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        objCaptureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
    }
    
    func addVideoPreviewLayer()
    {
        objCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: objCaptureSession)
        objCaptureVideoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        objCaptureVideoPreviewLayer?.frame = view.layer.bounds
        self.view.layer.addSublayer(objCaptureVideoPreviewLayer)
        objCaptureSession?.startRunning()
    }
    
    func initializeQRView() {
        vwQRCode = UIView()
        vwQRCode?.layer.borderColor = UIColor.redColor().CGColor
        vwQRCode?.layer.borderWidth = 5
        self.view.addSubview(vwQRCode!)
        self.view.bringSubviewToFront(vwQRCode!)
    }
    
    // optional func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!);
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!)
    {
        if metadataObjects == nil || metadataObjects.count == 0 || isSanning == true{
            vwQRCode?.frame = CGRectZero
            return
        }
        
        let objMetadataMachineReadableCodeObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if objMetadataMachineReadableCodeObject.type == AVMetadataObjectTypeQRCode {
            let objBarCode = objCaptureVideoPreviewLayer?.transformedMetadataObjectForMetadataObject(objMetadataMachineReadableCodeObject as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
            vwQRCode?.frame = objBarCode.bounds;
            
            
            if let qrValue = objMetadataMachineReadableCodeObject.stringValue {
                let storyBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                
                println("mon QR Code : \(qrValue)")
                var fullQrCode = split(qrValue) {$0 == ","}
                println(fullQrCode)
                
                for arg in fullQrCode {
                    
                    var data = split(arg) {$0 == ":"}
                    
                    var type = data[0]
                    var value = data[1]
                    
                    println("arg : type = \(type) -- value = \(value)")
                    
                    
                    
                    switch type {
                    case "Candidate" :
                        println("--- Candidate -- value=\(value)")
                        if let data = CandidateManager.SharedManager.searchCandidateWithMail(value) {
                            let viewController = storyBoard.instantiateViewControllerWithIdentifier("CandidateViewID") as! CandidateViewController
                            viewController.candidateSeleted = data
                            
                            self.navigationController?.pushViewController(viewController, animated: true)
                            self.isSanning = false
                        }
                        
                    case "Employee" :
                        println("--- Employee -- value=\(value)")
                        if let data = EmployeeManager.SharedManager.searchEmployeeWithMail(value) {
                            let viewController = storyBoard.instantiateViewControllerWithIdentifier("EmployeeViewID") as! EmployeeViewController
                            
                            println(data.contract.candidate?.firstName)
                            viewController.employee = data
                            
                            self.navigationController?.pushViewController(viewController, animated: true)
                            self.isSanning = false
                        }
                        
                    default :
                        println("No manage")
                    }
                }
                
                isSanning = true
            }
        }
    }
}
