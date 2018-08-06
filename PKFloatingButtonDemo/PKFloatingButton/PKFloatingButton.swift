//
//  PKFloatingButton.swift
//  PKFloatingButtonDemo
//
//  Created by Pramod Kumar on 06/03/18.
//  Copyright © 2018 Pramod Kumar. All rights reserved.
//

import UIKit

/**************************************************
 ************* PFFloatingButton Class *************
 **************************************************/

public class PKFloatingButton {
    
    //MARK:- Public Properties
    //MARK:-
    public static let shared = PKFloatingButton()
    
    //MARK:- Private Properties
    //MARK:-
    
    fileprivate var faddingTimer: Timer?
    
    let floatButton: UIButton = UIButton()
    
    fileprivate var buttonFloatingOn: UIView?
    fileprivate var viewToExpand: PKExpandableView = PKExpandableView()
    
    fileprivate var floatingButtonTapHandler: (()->())?
    
    fileprivate var lastPosition: CGPoint = CGPoint.zero
    
    //MARK:- Private Methods
    //MARK:-
    private init() {
        //        self.lastPosition = CGPoint(x: PKFloatingButtonConfiguration.shared.buttonSize.width / 2.0, y: (self.buttonFloatingOn?.frame.size.height ?? 0.0) / 2.0)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented in file \(#file) on line \(#line)")
    }
    
    fileprivate func initFloatButton(viewToExpand: UIView? = nil, withImage: UIImage? = nil) {
        
        //give the initial frame for loating button
        self.floatButton.frame = CGRect(x: self.lastPosition.x, y: self.lastPosition.y, width: PKFloatingButtonConfiguration.shared.buttonSize.width, height: PKFloatingButtonConfiguration.shared.buttonSize.height)
        
        //bueatify the bloating button
        self.floatButton.layer.cornerRadius = PKFloatingButtonConfiguration.shared.cornerRadius
        self.floatButton.layer.masksToBounds = true
        self.floatButton.backgroundColor = PKFloatingButtonConfiguration.shared.backgroundColor
        
        //set given image to floating button
        self.floatButton.setImage(withImage, for: UIControlState.normal)
        
        //add touch action event on floating button
        self.floatButton.addTarget(self, action: #selector(PKFloatingButton.floatButtonTapped(_:)), for: UIControlEvents.touchUpInside)
        
        //add pan gesture to drag the floating button
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(PKFloatingButton.panHandler(_:)))
        self.floatButton.addGestureRecognizer(panGesture)
        
        //        //set default position of floating button
        if self.lastPosition.x == 0.0 {
            self.lastPosition = CGPoint(x: PKFloatingButtonConfiguration.shared.buttonSize.width / 2.0, y: (self.buttonFloatingOn?.frame.size.height ?? PKFloatingButtonConfiguration.shared.buttonSize.width) / 2.0)
        }
        self.floatButton.center = self.lastPosition
        
        //create a view to expande
        self.viewToExpand = PKExpandableView(frame: (self.buttonFloatingOn?.frame ?? CGRect.zero), expandMinFrame: self.floatButton.frame, viewToExpand: viewToExpand)
        
        self.buttonFloatingOn?.addSubview(self.viewToExpand)
        
        //make button fade for first time
        self.shouldButtonFade(isFade: true, animated: false)
    }
    
    func shouldButtonFade(isFade: Bool, animated: Bool) {
        
        //make floating button fade in/out with animation
        UIView.animate(withDuration: animated ? PKFloatingButtonConfiguration.shared.fadeInAlpha : 0.0, animations: {
            
            self.floatButton.alpha = CGFloat(isFade ? PKFloatingButtonConfiguration.shared.fadeInAlpha : 1.0)
            
        }) { (completed) in
            if !isFade {
                //if button is not fade the run timer to make it fade after some time
                self.startTimer()
            }
        }
    }
    
    func startTimer() {
        //start the fadding timer
        self.stopTimer()
        self.faddingTimer = Timer.scheduledTimer(timeInterval: PKFloatingButtonConfiguration.shared.fadeInSeconds, target: self, selector: #selector(PKFloatingButton.timerHandler(_:)), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        //invalidate the timer
        self.faddingTimer?.invalidate()
        self.faddingTimer = nil
    }
    
    
    @objc private func timerHandler(_ timer: Timer) {
        //make float button fade after time executed, stop timer not to be executed next time
        self.stopTimer()
        self.shouldButtonFade(isFade: true, animated: true)
    }
    
    @objc private func floatButtonTapped(_ sender: UIButton) {
        
        if let handler = self.floatingButtonTapHandler {
            //execute the handler is passed
            handler()
        }
        
        if PKFloatingButtonConfiguration.shared.isExpandable {
            //expand the view to be shown
            self.viewToExpand.expand(floatButton: self.floatButton)
            //stop timer if executing
            self.stopTimer()
        }
    }
    
    @objc private func panHandler(_ gesture: UIPanGestureRecognizer) {
        //start the timer for fadding the floating button
        PKFloatingButton.shared.shouldButtonFade(isFade: false, animated: false)
        PKFloatingButton.shared.startTimer()
        
        if let gestureView = gesture.view, let floatSuperView = self.buttonFloatingOn {
            
            let topLimit: CGFloat = (PKFloatingButtonConfiguration.shared.buttonSize.height / 2.0) + PKFloatingButtonConfiguration.shared.padding
            let bottomLimit: CGFloat = (floatSuperView.frame.size.height - topLimit)
            let leftLimit: CGFloat = ((PKFloatingButtonConfiguration.shared.buttonSize.width / 2.0) + PKFloatingButtonConfiguration.shared.padding)
            let rightLimit: CGFloat = (floatSuperView.frame.size.width - leftLimit)
            
            let translation  = gesture.translation(in: gestureView)
            let lastLocation = self.floatButton.center
            
            var newX = lastLocation.x + translation.x
            var newY = lastLocation.y + translation.y
            
            newX = newX >= 0.0 ? newX : 0.0
            newX = newX <= floatSuperView.frame.size.width ? newX : floatSuperView.frame.size.width
            
            newY = newY >= 0.0 ? newY : 0.0
            newY = newY <= floatSuperView.frame.size.height ? newY : floatSuperView.frame.size.height
            
            if gesture.state == UIGestureRecognizerState.ended {
                func adjustXForTopAndBottmAlignement() {
                    newX = newX < leftLimit ? leftLimit : newX
                    newX = newX > rightLimit ? rightLimit : newX
                }
                
                //for top alignment
                if (0...(floatSuperView.frame.size.width) ~= newX), (newY <  (floatSuperView.frame.size.height / 5.0)) {
                    //y make it to top aligned
                    newY = topLimit
                    
                    //x shouldn't cross the boundaries limits
                    adjustXForTopAndBottmAlignement()
                }
                    //for bottom alignment
                else if (0...(floatSuperView.frame.size.width) ~= newX), (newY >  ((floatSuperView.frame.size.height / 5.0) * 4.0)) {
                    //y make it to bottom aligned
                    newY = bottomLimit
                    
                    //x shouldn't cross the boundaries limits
                    adjustXForTopAndBottmAlignement()
                }
                    //for all other cases
                else {
                    if (PKFloatingButtonConfiguration.shared.buttonSize.height * 2.0) > newY {
                        newY = topLimit
                    }
                    else if newY > (floatSuperView.frame.size.height - (PKFloatingButtonConfiguration.shared.buttonSize.height * 2.0)) {
                        newY = bottomLimit
                    }
                    
                    newX = newX < (floatSuperView.frame.size.width / 2.0) ? leftLimit : rightLimit
                }
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.floatButton.center = CGPoint(x: newX, y: newY)
                })
            }
            else {
                self.floatButton.center = CGPoint(x: newX, y: newY)
            }
            self.lastPosition = self.floatButton.center
            gesture.setTranslation(CGPoint.zero, in: gestureView)
        }
    }
    
    
    //MARK:- Public Methods
    //MARK:-
    public func enableFloating(onView: UIView, viewToExpand: UIView? = nil, withImage: UIImage? = nil, onTapHandler: (()->())? = nil) {
        self.floatingButtonTapHandler = onTapHandler
        //add floating button on the desired screen
        self.buttonFloatingOn = onView
        onView.addSubview(self.floatButton)
        
        self.initFloatButton(viewToExpand: viewToExpand, withImage: withImage)
    }
    
    public func disableFloating() {
        self.floatButton.removeFromSuperview()
    }
}
