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
    
    private var picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraView.frame = view.frame
        cameraView.logoutButton.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        cameraView.phollowButton.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        cameraView.swipeRight.addTarget(self, action: #selector(respondToSwipeGesture))
        phollowView.frame = view.frame
        phollowView.submitButton.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        phollowView.cancelButton.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        
        //add targets for swipe gestures (left)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        loadImagePicker()
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
        SendPhoto().sendPhoto(resizedImage)
    }
    
    func buttonAction(sender: UIButton!) {
        switch sender {
        case cameraView.logoutButton:
            logout()
        case cameraView.phollowButton:
            showPhollowPage()
        //define actions for phollow button
        case phollowView.submitButton:
            phollow()
        case phollowView.cancelButton:
            phollowView.removeFromSuperview()
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
        
    }
    
    func phollow() {
        PhollowSomeone().phollow(phollowView.usernameField.text!, phollowView: phollowView)
    }
    
    //add phollow function, swipe gestures function and imagepickercontroller function

}

