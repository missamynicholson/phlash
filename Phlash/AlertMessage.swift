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
        UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseOut, animations: {
            statusLabel.frame.origin.y = 0
            }, completion: nil)
        Delay().run(4.0) {
            self.dismissAlert(statusLabel)
        }
    }
    
    func dismissAlert(statusLabel: UILabel) {
        UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseOut, animations: {
            statusLabel.frame.origin.y = -60
            }, completion: { finished in
                statusLabel.text = ""
                statusLabel.hidden = true
        })
    }
}
