//
//  AlertMessage.swift
//  Phlash
//
//  Created by Amy Nicholson on 17/06/2016.
//  Copyright © 2016 Phlashers. All rights reserved.
//

import UIKit

class AlertMessage {
    
    func show(statusLabel: UILabel, message: String) {
        statusLabel.text = message
        statusLabel.hidden = false
        Delay().run(2.0) {
            self.dismissAlert(statusLabel)
        }
    }
    
    func dismissAlert(statusLabel: UILabel) {
        statusLabel.hidden = true
        statusLabel.text = ""
    }
}
