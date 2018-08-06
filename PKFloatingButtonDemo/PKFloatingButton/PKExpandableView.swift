//
//  PKExpandableView.swift
//  PKFloatingButton
//
//  Created by Pramod Kumar on 06/03/18.
//  Copyright © 2018 Pramod Kumar. All rights reserved.
//

import UIKit

/**************************************************
 ************* PKExpandableView Class *************
 **************************************************/
public class PKExpandableView: UIView {
    
    //MARK:- Enum to choose the expanding type
    //MARK:-
    public enum ExpandingRatio {
        case square, screen
    }
    
    
    //MARK:- Private Properties
    //MARK:-
    fileprivate var minExpandFrame = CGRect.zero, maxExpandFrame = CGRect.zero
    fileprivate var contentInsets: UIEdgeInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    
    
    //MARK:- Private Properties
    //MARK:-
    var expandingView: UIView?
    
    
    //MARK:- Life Cycle Methods
    //MARK:-
    convenience init() {
        self.init(frame: CGRect.zero, expandMinFrame: CGRect.zero)
    }
    
    init(frame: CGRect, expandMinFrame: CGRect, viewToExpand: UIView? = nil) {
        super.init(frame: frame)
        
        self.minExpandFrame = expandMinFrame
        
        //get the ration for expanding according to the expanding choice
        var ratio: CGFloat = 1.0
        if PKFloatingButtonConfiguration.shared.expandingRatio == ExpandingRatio.square {
            ratio = 1.0
        }
        else {
            ratio = self.frame.size.width / self.frame.size.height
        }
        
        let newWidth = self.frame.size.width - (self.contentInsets.left + self.contentInsets.right)
        let newHeight = newWidth / ratio
        
        //calculate and store the max size to expande
        self.maxExpandFrame = CGRect(x: self.contentInsets.left, y: self.contentInsets.top, width: newWidth, height: newHeight)
        
        //add expanding view if passed
        if let expView = viewToExpand {
            self.expandingView = expView
            expView.center = self.center
        }
        else {
            self.expandingView = UIView(frame: expandMinFrame)
        }
        
        self.expandingView!.alpha = 0.8
        self.expandingView!.backgroundColor = PKFloatingButtonConfiguration.shared.backgroundColor
        self.expandingView!.layer.cornerRadius = PKFloatingButtonConfiguration.shared.cornerRadius
        self.expandingView!.layer.masksToBounds = true
        self.expandingView!.autoresizesSubviews = true
        
        //add expanding view on main view
        self.addSubview(self.expandingView!)
        self.isHidden = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented in file \(#file) on line \(#line)")
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        //collape the expanded view on touch event
        self.collapse()
    }
    
    //MARK:- Public Methods
    //MARK:-
    func expand(floatButton: UIButton) {
        
        //unhide self to enable touch event
        self.isHidden = false
        
        //hide the floating button
        floatButton.isHidden = true
        
        //make expanding view as the button size
        self.minExpandFrame = floatButton.frame
        self.expandingView?.frame = floatButton.frame
        
        //expand with the animation
        UIView.animate(withDuration: 0.3, animations: {
            self.expandingView?.frame = self.maxExpandFrame
            self.expandingView?.center = self.center
        })
    }
    
    func collapse() {
        
        //start the timer for fadding the floating button
        PKFloatingButton.shared.shouldButtonFade(isFade: false, animated: false)
        PKFloatingButton.shared.startTimer()
        
        //collape the expanded view with animation
        UIView.animate(withDuration: 0.3, animations: {
            self.expandingView?.frame = self.minExpandFrame
        }, completion: { (sucess) in
            //show the floating button
            PKFloatingButton.shared.floatButton.isHidden = false
            //hide expanded view
            self.isHidden = true
        })
    }
}

