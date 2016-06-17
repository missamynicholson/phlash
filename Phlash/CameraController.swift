//
//  CameraController.swift
//  Phlash
//
//  Created by Ollie Haydon-Mulligan on 17/06/2016.
//  Copyright © 2016 Phlashers. All rights reserved.
//

import UIKit
import Parse

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private let screenBounds:CGSize = UIScreen.mainScreen().bounds.size
    private let cameraView = CameraView()
    private let phollowView = PhollowView()
    var statusLabel = UILabel()
    
    private var picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraView.frame = view.frame
        cameraView.logoutButton.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        cameraView.phollowButton.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        cameraView.swipeRight.addTarget(self, action: #selector(respondToSwipeGesture))
        cameraView.swipeLeft.addTarget(self, action: #selector(respondToSwipeGesture))
        phollowView.frame = CGRect(x: 0, y: screenBounds.height, width: screenBounds.width, height: screenBounds.height)
        phollowView.submitButton.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        phollowView.cancelButton.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        statusLabel = cameraView.statusLabel
        
        //add targets for swipe gestures (left)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        loadImagePicker()
        AlertMessage().show(statusLabel, message: "Welcome")
    }
    
    func loadImagePicker() {
        if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
            PickerSetup().makePickerFullScreen(picker)
            picker.delegate = self
            
            presentViewController(picker, animated: false, completion: {
                self.picker.cameraOverlayView = self.cameraView
            })
        }
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                picker.takePicture()
            case UISwipeGestureRecognizerDirection.Left:
                RetrievePhoto().showFirstPhlashImage(cameraView)
            default:
                break
            }
        }
    }
    
    func imagePickerController(picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let resizedImage = ResizeImage().resizeImage(chosenImage, newWidth: ImageViewFrame().getNewWidth(chosenImage))
        DisplayImage().setup(chosenImage, cameraView: cameraView, animate: false)
        SendPhoto().sendPhoto(resizedImage, statusLabel: cameraView.statusLabel)
    }
    
    func buttonAction(sender: UIButton!) {
        switch sender {
        case cameraView.logoutButton:
            logout()
        case cameraView.phollowButton:
            showPhollowPage()
        case phollowView.submitButton:
            phollow()
        case phollowView.cancelButton:
            cancelPhollowPage()
        default:
            break
        }
    }
    
    func logout() {
        PFUser.logOut()
        picker.dismissViewControllerAnimated(false, completion: {
            self.performSegueWithIdentifier("toAuth", sender: nil)
        })
    }
    
    func showPhollowPage() {
        cameraView.addSubview(phollowView)
        cameraView.identificationLabel.text = ""
        
        PhollowViewSetup().animate(phollowView, phollowButton: cameraView.phollowButton, logoutButton: cameraView.logoutButton, yValue: 0, appear: true, cameraViewId: cameraView.identificationLabel)
    }
    
    func phollow() {
        PhollowSomeone().phollow(phollowView.usernameField.text!, phollowView: phollowView, logoutButton: cameraView.logoutButton, phollowButton: cameraView.phollowButton, statusLabel: cameraView.statusLabel, cameraViewIdentificationLabel: cameraView.identificationLabel)
    }
    
    func cancelPhollowPage() {
       PhollowViewSetup().animate(phollowView, phollowButton: cameraView.phollowButton, logoutButton: cameraView.logoutButton, yValue: screenBounds.height, appear: false, cameraViewId: cameraView.identificationLabel)
    }
}

