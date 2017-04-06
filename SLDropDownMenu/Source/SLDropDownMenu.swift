//
//  SLDropDownMenu.swift
//  SLDropDownMenu
//
//  Created by Sai on 06/04/2017.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import UIKit


open class SLDropDownMenu: UIView, SLDropDownDelegate
{
    internal var opened: Bool = false
    internal var dropDownView: UIView?
    internal var bottomLine: UIView!
    

    /// Blur effect view will changed if you change this popperty. Backgorund view don't have to be blur view (e.g. UIColor.black)
    open var blurEffectView: UIView?
    {
        didSet {
            self.changeBlurEffectView()
        }
    }
    /// Alpha Value if animation ended in *hideMenu()* function
    open var blurEffectViewAlpha:CGFloat = 1.0
    
    /// Blur effect style in background view
    open var blurEffectStyle:UIBlurEffectStyle = .dark
    
    /// Make background blur view enabled
    open var backgroundBlurEnabled = true
    
    /// Show menu second default value: *0.5*
    open var showMenuDuration = 0.5
    
    /// Hide menu second default value: *0.3*
    open var hideMenuDuration = 0.3
    
    /// Show menu spring velocity default value: *0.5*
    open var showMenuSpringVelocity:CGFloat = 0.5
    
    /// Show menu spring damping default value: *0.8*
    open var showMenuSpringWithDamping:CGFloat = 0.8
    
    /// Hide menu spring velocity Default value: *0.9*
    open var hideMenuSpringVelocity:CGFloat = 0.9
    
    /// Hide menu spring damping Default value: *0.8*
    open var hideMenuSpringWithDamping:CGFloat = 0.8
    
    
    required public init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public init(frame: CGRect, dropDownView: UIView)
    {
        super.init(frame: frame)
        
        self.dropDownView = dropDownView
        self.initViews()
    }
    
    
    open func hideMenu()
    {
        guard opened else { return }
    
        hideMenu(completeHandler: nil)
        opened = !opened
    }
    
    
    open func toggleMenu()
    {
        if !opened
        {
            showMenu(completeHandler: nil)
        }
        else
        {
            hideMenu(completeHandler: nil)
        }

        opened = !opened
    }
    
    
    @objc internal func blurEffectViewClicked(_ sender: UITapGestureRecognizer)
    {
        self.hideMenu()
    }
    
    
    internal func showMenu(completeHandler: (()-> Void)?)
    {
        guard let dropDownView = dropDownView else {
            return
        }
        
        dropDownView.isHidden = false

        self.addSubview(dropDownView)
        self.sendSubview(toBack: dropDownView)
        
        if self.backgroundBlurEnabled, let _blurEffectView = blurEffectView
        {
            self.superview?.insertSubview(_blurEffectView, belowSubview: self)
        }
        
        UIView.animate(
            withDuration: self.showMenuDuration,
            delay: 0,
            usingSpringWithDamping: self.showMenuSpringWithDamping,
            initialSpringVelocity: self.showMenuSpringVelocity,
            options: [],
            animations: {
                dropDownView.frame.origin.y = 0
                if self.backgroundBlurEnabled
                {
                    self.blurEffectView?.alpha = self.blurEffectViewAlpha
                }
                
                self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: dropDownView.frame.height)
                
        }, completion: { _ in
            completeHandler?()
        })
    }
    
    
    internal func hideMenu(completeHandler: (()-> Void)?)
    {
        
        guard let dropDownView = dropDownView else {
            return
        }
        
        UIView.animate(
            withDuration: self.hideMenuDuration,
            delay: 0,
            usingSpringWithDamping: self.hideMenuSpringWithDamping,
            initialSpringVelocity: self.hideMenuSpringVelocity,
            options: [],
            animations: {
                dropDownView.frame.origin.y = 0
                if self.backgroundBlurEnabled
                {
                    self.blurEffectView?.alpha = 0
                }
                self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: 0)

        }, completion: { _ in
            if self.backgroundBlurEnabled
            {
                self.blurEffectView?.removeFromSuperview()
                dropDownView.isHidden = true
            }
            completeHandler?()
        })
    }
    
    
    internal func changeBlurEffectView()
    {
        self.blurEffectView?.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: UIScreen.main.bounds.size.height - self.frame.origin.y)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(blurEffectViewClicked(_:)))
        self.blurEffectView?.addGestureRecognizer(tapGesture)
        self.blurEffectView?.alpha = 0
    }
    
    
    internal func initViews()
    {
        self.clipsToBounds = true
        self.backgroundColor = .white
        
        if let dropDownView = dropDownView
        {
            dropDownView.frame.size = CGSize(width: self.bounds.size.width, height: dropDownView.frame.height)
            dropDownView.frame.origin.y = -dropDownView.frame.height
        }
        
        if let _dropDownView = dropDownView as? SLDropDownView
        {
            _dropDownView.delegate = self
        }
        
        self.bottomLine = UIView(frame: CGRect(x: 0, y: 0.5, width: self.frame.width, height: 0.5))
        self.bottomLine.backgroundColor = UIColor(colorLiteralRed: 225/255, green: 225/255, blue: 225/255, alpha: 1.0)
        self.bottomLine.isHidden = true
        self.addSubview(self.bottomLine)
        
        let blurEffect = UIBlurEffect(style: blurEffectStyle)
        self.blurEffectView = UIVisualEffectView(effect: blurEffect)
        self.blurEffectView?.alpha = 0
        
        self.blurEffectView?.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: UIScreen.main.bounds.size.height - self.frame.origin.y)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(blurEffectViewClicked(_:)))
        self.blurEffectView?.addGestureRecognizer(tapGesture)
    }
}
