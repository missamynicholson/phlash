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
    var pendingPhlashesButton = UIButton()
    var phlashesArray = [PFObject]()
    
    
    private var picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraView.frame = view.frame
        cameraView.settingsButton.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        cameraView.phollowButton.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        cameraView.flipCamera.addTarget(self, action: #selector(buttonAction),forControlEvents: .TouchUpInside)
        cameraView.swipeRight.addTarget(self, action: #selector(respondToSwipeGesture))
        cameraView.swipeLeft.addTarget(self, action: #selector(respondToSwipeGesture))
        cameraView.panGesture.addTarget(self, action: #selector(handlePanGesture))
        
        
        cameraView.tap.addTarget(self, action: #selector(dismissKeyboard))
        phollowView.frame = CGRect(x: 0, y: screenBounds.height, width: screenBounds.width, height: screenBounds.height)
        phollowView.createPhollowButton.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        phollowView.destroyPhollowButton.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        phollowView.cancelButton.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        //checkPendingPhlashesStatus()
        //pendingPhlashesButton = cameraView.pendingPhlashesButton
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
                showPhlash()
            default:
                break
            }
        }
    }
    
    func checkPendingPhlashesStatus() {
        if self.phlashesArray.count > 0 {
            self.pendingPhlashesButton.hidden = false
        } else {
            RetrievePhoto().queryDatabaseForPhotos({ (phlashesFromDatabase, error) -> Void in
                self.phlashesArray = phlashesFromDatabase!
                self.togglePhlashesLabel()
            })
        }
    }
    
    func togglePhlashesLabel() {
        if self.phlashesArray.count < 1 {
            self.pendingPhlashesButton.hidden = true
        } else {
            self.pendingPhlashesButton.hidden = false
        }
    }
    
    func showPhlash() {
        if phlashesArray.count > 0 {
            let firstPhlash = phlashesArray.first!
            NSUserDefaults.standardUserDefaults().setObject(firstPhlash.createdAt, forKey: "lastSeen")
            phlashesArray.removeAtIndex(0)
            RetrievePhoto().showFirstPhlashImage(cameraView, firstPhlash: firstPhlash)
        } else {
            AlertMessage().show(statusLabel, message: "No phlashes! Try again later.")
        }
        checkPendingPhlashesStatus()
    }
    
    func imagePickerController(picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        var chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        if picker.cameraDevice == UIImagePickerControllerCameraDevice.Front {
            chosenImage =  UIImage(CGImage: chosenImage.CGImage!, scale: chosenImage.scale, orientation:.LeftMirrored)
        }
        
        let captionField = cameraView.captionField
        
        guard captionField.text?.characters.count < 100 else {
            AlertMessage().show(statusLabel, message: "Oops, caption cannot be more than 100 characters")
            return
        }
        
        let resizedImage = ResizeImage().resizeImage(chosenImage, newWidth: ImageViewFrame().getNewWidth(chosenImage))
        DisplayImage().setup(chosenImage, cameraView: cameraView, animate: false, username: "", caption: "", yValue: "")
        SendPhoto().sendPhoto(resizedImage, statusLabel: statusLabel, captionField: captionField)
    }
    
    func buttonAction(sender: UIButton!) {
        switch sender {
        case cameraView.settingsButton:
            //logout()
            showSettingsView()
        case cameraView.phollowButton:
            showPhollowPage()
        case phollowView.createPhollowButton:
            phollow()
        case phollowView.destroyPhollowButton:
            unphollow()
        case phollowView.cancelButton:
            cancelPhollowPage()
        case cameraView.flipCamera:
            flipFrontBackCamera()
        default:
            break
        }
    }
    
    func showSettingsView() {
        if cameraView.settingsView.frame.origin.y < 0 {
            UIView.animateWithDuration(1.0, delay: 0.0, options: .CurveEaseOut, animations: {
                self.cameraView.settingsView.frame.origin.y = self.screenBounds.width/5
                }, completion: nil)
        } else {
        UIView.animateWithDuration(1.0, delay: 0.0, options: .CurveEaseOut, animations: {
            self.cameraView.settingsView.frame.origin.y = -self.screenBounds.width
            }, completion: nil)
        }
    }
    
    func flipFrontBackCamera(){
        picker.cameraDevice = picker.cameraDevice == UIImagePickerControllerCameraDevice.Front ? UIImagePickerControllerCameraDevice.Rear : UIImagePickerControllerCameraDevice.Front
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
        
        PhollowViewSetup().animate(phollowView, phollowButton: cameraView.phollowButton, logoutButton: cameraView.settingsButton, yValue: 0, appear: true, cameraViewId: cameraView.identificationLabel)
    }
    
    func phollow() {
        PhollowSomeone().phollow(phollowView.usernameField, phollowView: phollowView, logoutButton: cameraView.settingsButton, phollowButton: cameraView.phollowButton, statusLabel: phollowView.statusLabel, cameraViewIdentificationLabel: cameraView.identificationLabel)
    }
    
    func unphollow() {
        UnPhollowSomeone().unPhollow(phollowView.usernameField, phollowView: phollowView, logoutButton: cameraView.settingsButton, phollowButton: cameraView.phollowButton, statusLabel: cameraView.statusLabel, cameraViewIdentificationLabel: cameraView.identificationLabel)
    }
    
    func cancelPhollowPage() {
        PhollowViewSetup().animate(phollowView, phollowButton: cameraView.phollowButton, logoutButton: cameraView.settingsButton, yValue: screenBounds.height, appear: false, cameraViewId: cameraView.identificationLabel)
    }
    
   func handlePanGesture(panGesture: UIPanGestureRecognizer) {
        
        let translation = panGesture.translationInView(cameraView)
        let newCenter = CGPoint(x: screenBounds.width/2, y: panGesture.view!.center.y + translation.y)
        
        if newCenter.y <= (screenBounds.height*16/17 - screenBounds.height/30) && newCenter.y >= screenBounds.height/30 {
            panGesture.view!.center = newCenter
            panGesture.setTranslation(CGPointZero, inView: cameraView)
        }
        
    }
}
