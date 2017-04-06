//
//  FilterMemeView.swift
//  Example
//
//  Created by Sai on 06/04/2017.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import UIKit

class FilterMemeView: SLDropDownView
{
    @IBOutlet var segmentControl: UISegmentedControl!
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
    }
    
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    
    @IBAction func cancelButtonClicked(_ sender: Any)
    {
        self.hideMenu()
    }
    
    
    @IBAction func confirmButtonClicked(_ sender: Any)
    {
        self.hideMenu()
    }
}
