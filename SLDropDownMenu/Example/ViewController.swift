//
//  ViewController.swift
//  Example
//
//  Created by Sai on 06/04/2017.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    private var dropDownMenu: SLDropDownMenu!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Example"
        self.navigationController?.navigationBar.isHidden = false
        
        if let dropDownView = Bundle.main.loadNibNamed("DropDownView", owner: nil, options: nil) as? [UIView]
        {
            dropDownMenu = SLDropDownMenu(frame: CGRect(x: 0, y: 64 + 38, width: UIScreen.main.bounds.size.width, height: 0), dropDownView: dropDownView[0])
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .black
            dropDownMenu.blurEffectView = backgroundView
            dropDownMenu.blurEffectViewAlpha = 0.5
            dropDownMenu.bottomLine.isHidden = false
            
            self.view.addSubview(dropDownMenu)
        }
        
        let button = UIButton(frame: CGRect(x: 0, y: 64, width: UIScreen.main.bounds.size.width, height: 38))
        button.backgroundColor = UIColor.white
        button.setTitle("下拉菜单", for: .normal)
        button.setTitleColor(UIColor(red: 1.0, green: 164/255.0, blue: 9/255.0, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(toggleMenu), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    
    func toggleMenu()
    {
        dropDownMenu.toggleMenu()
    }
}

