//
//  SLDropDownView.swift
//  SLDropDownMenu
//
//  Created by Sai on 06/04/2017.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import UIKit

open class SLDropDownView: UIView
{
    open weak var delegate: SLDropDownDelegate?
    
    open func hideMenu()
    {
        self.delegate?.hideMenu()
    }
}
