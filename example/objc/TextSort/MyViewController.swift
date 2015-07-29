//
//  MyViewController.swift
//  TextSort
//
//  Created by Hans Malherbe on 2015/07/29.
//  Copyright (c) 2015 Dropbox, Inc. All rights reserved.
//

import UIKit

@objc
class MyViewController: UIViewController {
    var textView: UITextView!
    var sortItems: TXSSortItems!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.backgroundColor = UIColor.whiteColor().CGColor
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "dismissKeyboard:"))
        
        
        //view.layer.backgroundColor = UIColor.grayColor().CGColor
        let navBar = UINavigationBar(frame: CGRect.zeroRect)
        navBar.setTranslatesAutoresizingMaskIntoConstraints(false)
        navBar.setItems([UINavigationItem(title: "Login")], animated: false)
        view.addSubview(navBar)
        
        let sortButton = UIButton.buttonWithType(.System) as! UIButton
        let resortButton = UIButton.buttonWithType(.System) as! UIButton
        let randomButton = UIButton.buttonWithType(.System) as! UIButton
        
        sortButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        resortButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        randomButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        sortButton.setTitle("Sort", forState: .Normal)
        resortButton.setTitle("Resort", forState: .Normal)
        randomButton.setTitle("Random", forState: .Normal)
        
        view.addSubview(sortButton)
        view.addSubview(resortButton)
        view.addSubview(randomButton)
        
        sortButton.addTarget(self, action: "buttonClicked:", forControlEvents: .TouchUpInside)
        resortButton.addTarget(self, action: "buttonClicked:", forControlEvents: .TouchUpInside)
        randomButton.addTarget(self, action: "buttonClicked:", forControlEvents: .TouchUpInside)
        
        
        textView = UITextView(frame: CGRect.zeroRect)
        textView.layer.borderColor = UIColor.redColor().CGColor
        textView.layer.borderWidth = 2.3
        textView.layer.cornerRadius = 5
        textView.layer.backgroundColor = UIColor.whiteColor().CGColor
        textView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        view.addSubview(textView)
        
        let views = ["navBar":navBar, "sortButton":sortButton, "resortButton":resortButton, "randomButton":randomButton, "textView":textView]
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|[navBar]|", options: nil, metrics: nil, views: views))
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[navBar(60)]-[textView(>=100)]-[sortButton(==resortButton,==randomButton)]-10-|", options: nil, metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[resortButton]-10-|", options: nil, metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[randomButton]-10-|", options: nil, metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-[sortButton][resortButton(>=50)][randomButton]-|", options: nil, metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|[textView]|", options: nil, metrics: nil, views: views))
        
        var textListener = TXSTextboxListenerImpl(UITextView: textView)
        sortItems = TXSSortItems.createWithListener(textListener)

    }
    
    func buttonClicked(sender: UIButton) {
        switch (sender.titleLabel!.text!) {
        case "Sort": sortWithOrder(.Ascending); break;
        case "Resort": sortWithOrder(.Descending); break;
        case "Random": sortWithOrder(.Random); break;
        default: println("fout");
        }
    }
    
    func sortWithOrder(sortOrder: TXSSortOrder) {
        let str = textView.text
        let strList = str.componentsSeparatedByString("\n")
        let itemList = TXSItemList(items:strList)
        sortItems.sort(sortOrder, items: itemList)
    }
    
    func dismissKeyboard(recognizer: UITapGestureRecognizer) {
        textView.resignFirstResponder()
    }
}
