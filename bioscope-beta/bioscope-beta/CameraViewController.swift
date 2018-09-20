//
//  CameraViewController.swift
//  bioscope-beta
//
//  Created by HoHo on 9/20/18.
//  Copyright © 2018 Raymond Kim. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    
    //need library AVFoundation
    var captureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    
    var photoOutput: AVCapturePhotoOutput?
    
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    
    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession() //create capture session
        setupDevice()         //configuring capture devices (front or back camera)
        setupInputOutput()    //create input using capture devices
        setupPreviewLayer()   //configure capture output object
        startRunningCaptureSession()
        // Do any additional setup after loading the view.
    }
    
    func setupCaptureSession() {
        //defind the resolution Preset photo is default to full resolution
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }
    
    func setupDevice() {
        //find all available devices such as microphone,wide angle camera
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        
        let devices = deviceDiscoverySession.devices
        
        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                backCamera = device
            }
            else if device.position == AVCaptureDevice.Position.front {
                frontCamera = device
            }
        }
        //default to be backcamera
        currentCamera = backCamera
    }
    
    func setupInputOutput() {
        do{
            //use current camera to capture
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
            //to provide input
            captureSession.addInput(captureDeviceInput)
            
            photoOutput = AVCapturePhotoOutput()
            
            //use jpeg format
            photoOutput!.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey:AVVideoCodecType.jpeg])], completionHandler: nil)
            captureSession.addOutput(photoOutput!)
        } catch{
            //ensure the device has camera
            print(error)
        }
    }
    
    func setupPreviewLayer() {
        //capture the instance of the image
        self.cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        //determin how preview is display , for full screnn resizeAspectFill
        self.cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        self.cameraPreviewLayer?.frame = self.view.frame
        self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
    }
    
    func startRunningCaptureSession() {
        captureSession.startRunning()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cameraButton_TouchUpInside(_ sender: Any) {
        let settings = AVCapturePhotoSettings()
        self.photoOutput?.capturePhoto(with: settings, delegate: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhoto_Segue" {
            let previewVC = segue.destination as! PreviewViewController
            previewVC.image = self.image
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension CameraViewController: AVCapturePhotoCaptureDelegate{
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation(){
            //print(imageData)
            self.image = UIImage(data: imageData)
            performSegue(withIdentifier: "showPhoto_Segue", sender: nil)
        }
    }
}
