//
//  HelpView.swift
//  Phlash
//
//  Created by Amy Nicholson on 21/06/2016.
//  Copyright © 2016 Phlashers. All rights reserved.
//

import UIKit

class HelpView: UIView, UITextFieldDelegate {
    
    var cancelButton = UIButton()
    private let whiteColor = UIColor.whiteColor()
    private let backgroundGreen: UIColor = UIColor( red: CGFloat(48/255.0), green: CGFloat(227/255.0), blue: CGFloat(202/255.0), alpha: CGFloat(0.75))
    let FONT_SIZE = UIScreen.mainScreen().bounds.size.width/10
    let screenBounds: CGSize = UIScreen.mainScreen().bounds.size
    let commentsLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        addCancelButton()
        addCommentsLabel()
        backgroundColor = backgroundGreen
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addCancelButton() {
        cancelButton.frame = CGRect(x: screenBounds.width*4/5, y: 20, width: screenBounds.width/5, height: 30)
        cancelButton.setTitleColor(.whiteColor(), forState: .Normal)
        cancelButton.titleLabel!.font = UIFont.systemFontOfSize(FONT_SIZE)
        cancelButton.setTitle("x", forState: .Normal)
        cancelButton.accessibilityLabel = "cancel"
        addSubview(cancelButton)
    }
    
    func addCommentsLabel() {
        commentsLabel.frame = CGRect(x:screenBounds.width/10, y: 0, width: screenBounds.width*4/5, height:screenBounds.height)
        commentsLabel.textColor = whiteColor
        commentsLabel.text = "Welcome to Phlash!\n\n\n\n\nSwipe right to capture and send a phlash to your phollowers - there's no preview, just swipe and go!\n\n\nSwipe left to view phlashes from other people."
        commentsLabel.textAlignment = .Center
        commentsLabel.numberOfLines = 20
        addSubview(commentsLabel)
    }
    
    
    
}
