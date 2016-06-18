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
    
    var phlashesArray:[PFObject] = []
    
    func showFirstPhlashImage(cameraView: UIView, firstPhlash: PFObject) {
        let userImageFile = firstPhlash["file"] as! PFFile
        userImageFile.getDataInBackgroundWithBlock {
            (imageData: NSData?, error: NSError?) -> Void in
            if error == nil {
                if let imageData = imageData {
                    let chosenImage = UIImage(data:imageData)!
                    let username = "\(firstPhlash["username"])"
                    let caption = "\(firstPhlash["caption"])"
                    DisplayImage().setup(chosenImage, cameraView: cameraView, animate: true, username: username, caption: caption)
                }
            }
        }
    }
    
    func queryDatabaseForPhotos(getPhlashes: (phlashesFromDatabase : [PFObject]?, error : NSError?) -> Void) {
        //let lastSeenDate = defaults.objectForKey("lastSeen")
        
        let currentUser = PFUser.currentUser()
        let currentUsername = currentUser!.username!
        
        let phollowing = PFQuery(className:"Phollow")
        phollowing.whereKey("fromUsername", equalTo:currentUsername)
        
        let phlashes = PFQuery(className: "Phlash")
        phlashes.whereKey("username", matchesKey: "toUsername", inQuery: phollowing)
        //phlashes.whereKey("createdAt", greaterThan: lastSeenDate!)
        phlashes.orderByAscending("createdAt")
        
        
        phlashes.findObjectsInBackgroundWithBlock {
            (results: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                getPhlashes(phlashesFromDatabase: results, error: error)
            }
        }
    }
}


