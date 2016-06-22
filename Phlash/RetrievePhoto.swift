//
//  RetrievePhoto().swift
//  Phlash
//
//  Created by Ollie Haydon-Mulligan on 17/06/2016.
//  Copyright © 2016 Phlashers. All rights reserved.
//

import Parse
import UIKit

class RetrievePhoto {
    
    func showFirstPhlashImage(cameraView: UIView, firstPhlash: PFObject, swipeLeft: UIGestureRecognizer, swipeRight: UIGestureRecognizer) {
        let userImageFile = firstPhlash["file"] as! PFFile
        userImageFile.getDataInBackgroundWithBlock {
            (imageData: NSData?, error: NSError?) -> Void in
            if error == nil {
                if let imageData = imageData {
                    let chosenImage = UIImage(data:imageData)!
                    let username = "\(firstPhlash["username"])"
                    let caption = "\(firstPhlash["caption"])"
                    let yValue = "\(firstPhlash["yValue"])"
                    DisplayImage().setup(chosenImage, cameraView: cameraView, animate: true, username: username, caption: caption, yValue: yValue, swipeLeft: swipeLeft, swipeRight: swipeRight)
                }
            }
        }
    }
    
    func queryDatabaseForPhotos(getPhlashes: (phlashesFromDatabase : [PFObject]?, error : NSError?) -> Void) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let dateInPast = NSDate(timeIntervalSinceReferenceDate: 0)
        var lastSeenDate = dateInPast
        
        if defaults.objectForKey("lastSeen") != nil {
            lastSeenDate = defaults.objectForKey("lastSeen") as! NSDate
        }
        
        PFCloud.callFunctionInBackground("query", withParameters: ["lastSeen": lastSeenDate]) {
            (response: AnyObject?, error: NSError?) -> Void in
            
            if error == nil {
                let results = response as? [PFObject]
                getPhlashes(phlashesFromDatabase: results, error: error)
                if results!.count > 0 {
                    NSUserDefaults.standardUserDefaults().setObject(results!.last!.createdAt, forKey: "lastSeen")
                } else {
                    NSUserDefaults.standardUserDefaults().setObject(NSDate(), forKey: "lastSeen")
                }
            }
        }
    }
}