//
//  HelpViewSetup.swift
//  Phlash
//
//  Created by Amy Nicholson on 21/06/2016.
//  Copyright © 2016 Phlashers. All rights reserved.
//

import UIKit

class HelpViewSetup {
    
    func animate(helpView: UIView,  yValue: CGFloat, appear: Bool) {
        UIView.animateWithDuration(1.0, delay: 0.0, options: .CurveEaseOut, animations: {
            helpView.frame.origin.y = yValue
            }, completion: { finished in
                if !appear {
                    helpView.removeFromSuperview()
                }
        })
    }
}
