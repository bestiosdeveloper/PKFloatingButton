//
//  PKFloatingButtonConfiguration.swift
//  PKFloatingButton
//
//  Created by Pramod Kumar on 06/03/18.
//  Copyright © 2018 Pramod Kumar. All rights reserved.
//

import UIKit


/**************************************************
 ************* PKExpandableView Class *************
 **************************************************/

/*
 * A class that used to give the configuration for the PKFloatingButton *
 * All the properties have their default value *
 * To make change in the properties set the properties values in `didFinishLaunchingWithOptions` method of Appdelegate *
 */
public class PKFloatingButtonConfiguration {
    
    //MARK:- Properties
    //MARK:-
    public static let shared = PKFloatingButtonConfiguration()
    
    /* `backgroundColor`
     * Description: used to set the background color of the floadting button as well as expandable view.
     * Default: default value is `darkGray`
     */
    public var backgroundColor: UIColor = UIColor.darkGray
    
    /* `padding`
     * Description: used to set padding of the floating button from the screen corners.
     * Default: default value is `3.0`
     */
    public var padding: CGFloat = 3.0
    
    /* `cornerRadius`
     * Description: used to round the corners of the floating button.
     * Default: default value is `10.0`
     */
    public var cornerRadius: CGFloat = 10.0
    
    /* `fadeInSeconds`
     * Description: used to fade the floating button after the tap/collapsing.
     * Default: default value is `1` secons.
     */
    public var fadeInSeconds: TimeInterval = 1.0
    
    /* `fadeInAlpha`
     * Description: used to set alpha of the floating button in the idel condition or after the collapsing.
     * Default: default value is `0.5`
     */
    public var fadeInAlpha: Double = 0.5
    
    /* `buttonSize`
     * Description: used to give the size of the floating button.
     * Default: default value is `60.0`
     */
    public var buttonSize: CGSize = CGSize(width: 60.0, height: 60.0)
    
    /* `isExpandable`
     * Description: used enable/disable the expanding property of the floating button.
     * Default: default value is `darkGray`
     */
    public var isExpandable: Bool = true
    
    
    /* `expandingRatio`
     * Description: used set the ratio, is what ratio the view should be expand.
     * Default: default value is `square`
     */
    public var expandingRatio = PKExpandableView.ExpandingRatio.square

}
