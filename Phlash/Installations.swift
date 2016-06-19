//
//  Installations.swift
//  Phlash
//
//  Created by Amy Nicholson on 19/06/2016.
//  Copyright © 2016 Phlashers. All rights reserved.
//

import Parse

class Installations {
    func updateInstallation(channel: String) {
        let currentInstallation = PFInstallation.currentInstallation()
        currentInstallation.addUniqueObject(channel, forKey: "channels")
        currentInstallation.saveInBackground()
    }
}
