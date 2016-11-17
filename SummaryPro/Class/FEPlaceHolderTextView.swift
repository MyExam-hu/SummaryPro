//
//  FEPlaceHolderTextView.swift
//  eCall
//
//  Created by echo on 2016/10/22.
//  Copyright © 2016年 echo. All rights reserved.
//

import UIKit

class FEPlaceHolderTextView: UITextView {

    var placeholder :String!
    var placeholderColor :UIColor?
    var placeHolderLabel :UILabel?
    
    override var text: String! {
        didSet
        {
            self.textChanged(NSNotification())
        }
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if self.placeholder == nil {
            self.placeholder=""
        }
        
        if self.placeholderColor == nil {
            self.placeholderColor=UIColor.lightGray
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(textChanged(_:)), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.placeholder=""
        self.placeholderColor=UIColor.lightGray
        NotificationCenter.default.addObserver(self, selector: #selector(textChanged(_:)), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        fatalError("init(coder:) has not been implemented")
    }
    
    func textChanged(_ notification : NSNotification) -> Void {
        if self.placeholder == "" {
            return
        }
        
        UIView.animate(withDuration: 0.25) { 
            if self.text == "" {
                self.viewWithTag(999)?.alpha=1
            }else{
                self.viewWithTag(999)?.alpha=0
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        if self.placeholder != "" {
            if self.placeHolderLabel == nil {
                self.placeHolderLabel=UILabel.init(frame: CGRect.init(x: 16, y: 18, width: self.bounds.size.width, height: 10))
                self.placeHolderLabel?.lineBreakMode = .byWordWrapping
                self.placeHolderLabel?.font=self.font
                self.placeHolderLabel?.backgroundColor=UIColor.clear
                self.placeHolderLabel?.textColor=self.placeholderColor
                self.placeHolderLabel?.alpha=0
                self.placeHolderLabel?.tag=999
                self.addSubview(self.placeHolderLabel!)
            }
            self.placeHolderLabel?.text=self.placeholder
            self.placeHolderLabel?.sizeToFit()
            self.sendSubview(toBack: self.placeHolderLabel!)
        }
        
        if self.text == "" && self.placeholder != "" {
            self.viewWithTag(999)?.alpha=1
        }
        
        super.draw(rect)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
