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
    var phlashesArray = [PFObject]()
    
    private var picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phlashesArray = []
        cameraView.frame = view.frame
        cameraView.logoutButton.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        cameraView.phollowButton.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        cameraView.swipeRight.addTarget(self, action: #selector(respondToSwipeGesture))
        cameraView.swipeLeft.addTarget(self, action: #selector(respondToSwipeGesture))
        cameraView.tap.addTarget(self, action: #selector(dismissKeyboard))
        phollowView.frame = CGRect(x: 0, y: screenBounds.height, width: screenBounds.width, height: screenBounds.height)
        phollowView.submitButton.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        phollowView.cancelButton.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        
        statusLabel = cameraView.statusLabel
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        loadImagePicker()
        AlertMessage().show(statusLabel, message: "Welcome")
    }
    
    func dismissKeyboard() {
        cameraView.endEditing(true)
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
                checkForPhlashes()
            default:
                break
            }
        }
    }
    
    func checkForPhlashes() {
        if phlashesArray.count < 1 {
            RetrievePhoto().queryDatabaseForPhotos({ (phlashesFromDatabase, error) -> Void in
                self.phlashesArray = phlashesFromDatabase!
                self.showPhlash()
            })
        } else {
            showPhlash()
            
        }
    }
    
    func showPhlash() {
        if phlashesArray.count > 0 {
            RetrievePhoto().showFirstPhlashImage(cameraView, firstPhlash: phlashesArray.first!)
            phlashesArray.removeAtIndex(0)
        } else {
            AlertMessage().show(statusLabel, message: "No phlashes! Try again later.")
        }
    }
    
    func imagePickerController(picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let captionField = cameraView.captionField
        let resizedImage = ResizeImage().resizeImage(chosenImage, newWidth: ImageViewFrame().getNewWidth(chosenImage))
        DisplayImage().setup(chosenImage, cameraView: cameraView, animate: false, username: "", caption: "")
        SendPhoto().sendPhoto(resizedImage, statusLabel: cameraView.statusLabel, captionField: captionField)
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

