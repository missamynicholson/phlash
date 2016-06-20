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
    var pendingPhlashesLabel = UILabel()
    var phlashesArray = [PFObject]()
    
    
    private var picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraView.frame = view.frame
        cameraView.logoutButton.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        cameraView.phollowButton.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        cameraView.flipCamera.addTarget(self, action: #selector(buttonAction),forControlEvents: .TouchUpInside)
        cameraView.swipeRight.addTarget(self, action: #selector(respondToSwipeGesture))
        cameraView.swipeLeft.addTarget(self, action: #selector(respondToSwipeGesture))
        cameraView.panGesture.addTarget(self, action: #selector(handlePanGesture))
        
        
        cameraView.tap.addTarget(self, action: #selector(dismissKeyboard))
        phollowView.frame = CGRect(x: 0, y: screenBounds.height, width: screenBounds.width, height: screenBounds.height)
        phollowView.submitButton.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        phollowView.cancelButton.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        checkPendingPhlashesStatus()
        pendingPhlashesLabel = cameraView.pendingPhlashesLabel
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
            self.pendingPhlashesLabel.hidden = false
        } else {
            RetrievePhoto().queryDatabaseForPhotos({ (phlashesFromDatabase, error) -> Void in
                self.phlashesArray = phlashesFromDatabase!
                self.togglePhlashesLabel()
            })
        }
    }
    
    func togglePhlashesLabel() {
        if self.phlashesArray.count < 1 {
            self.pendingPhlashesLabel.hidden = true
        } else {
            self.pendingPhlashesLabel.hidden = false
        }
    }
    
    func showPhlash() {
        if phlashesArray.count > 0 {
            RetrievePhoto().showFirstPhlashImage(cameraView, firstPhlash: phlashesArray.first!)
            phlashesArray.removeAtIndex(0)
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
        case cameraView.logoutButton:
            logout()
        case cameraView.phollowButton:
            showPhollowPage()
        case phollowView.submitButton:
            phollow()
        case phollowView.cancelButton:
            cancelPhollowPage()
        case cameraView.flipCamera:
            flipFrontBackCamera()
        default:
            break
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
        
        PhollowViewSetup().animate(phollowView, phollowButton: cameraView.phollowButton, logoutButton: cameraView.logoutButton, yValue: 0, appear: true, cameraViewId: cameraView.identificationLabel)
    }
    
    func phollow() {
        PhollowSomeone().phollow(phollowView.usernameField, phollowView: phollowView, logoutButton: cameraView.logoutButton, phollowButton: cameraView.phollowButton, statusLabel: phollowView.statusLabel, cameraViewIdentificationLabel: cameraView.identificationLabel)
    }
    
    func cancelPhollowPage() {
        PhollowViewSetup().animate(phollowView, phollowButton: cameraView.phollowButton, logoutButton: cameraView.logoutButton, yValue: screenBounds.height, appear: false, cameraViewId: cameraView.identificationLabel)
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
