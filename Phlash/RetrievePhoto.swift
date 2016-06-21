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
    
    func showFirstPhlashImage(cameraView: UIView, firstPhlash: PFObject) {
        let userImageFile = firstPhlash["file"] as! PFFile
        userImageFile.getDataInBackgroundWithBlock {
            (imageData: NSData?, error: NSError?) -> Void in
            if error == nil {
                if let imageData = imageData {
                    let chosenImage = UIImage(data:imageData)!
                    let username = "\(firstPhlash["username"])"
                    let caption = "\(firstPhlash["caption"])"
                    let yValue = "\(firstPhlash["yValue"])"
                    DisplayImage().setup(chosenImage, cameraView: cameraView, animate: true, username: username, caption: caption, yValue: yValue)
                }
            }
        }
    }
    
    func queryDatabaseForPhotos(getPhlashes: (phlashesFromDatabase : [PFObject]?, error : NSError?) -> Void) {
        let defaults = NSUserDefaults.standardUserDefaults()
        // let twentyFourHoursSince = NSDate(timeIntervalSinceReferenceDate: -86400.0)
        var lastSeenDate = NSDate()
        
        if defaults.objectForKey("lastSeen") == nil {
            lastSeenDate = NSCalendar.currentCalendar().dateByAddingUnit(NSCalendarUnit.Month, value: -1, toDate: NSDate(), options: NSCalendarOptions.init(rawValue: 0))!
        } else {
            lastSeenDate = defaults.objectForKey("lastSeen") as! NSDate
        }
        
        
        PFCloud.callFunctionInBackground("query", withParameters: ["lastSeen": lastSeenDate]) {
            (response: AnyObject?, error: NSError?) -> Void in

            if error == nil {
                getPhlashes(phlashesFromDatabase: response as? [PFObject], error: error)
            }
        }
    }
}