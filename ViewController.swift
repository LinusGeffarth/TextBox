//
//  ViewController.swift
//  TextBox
//
//  Created by Linus Geffarth on 17.04.16.
//  Copyright © 2016 Linus Geffarth. All rights reserved.
//

/*
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/


import UIKit

var handleViews: [HandleView] = []
var tb = ResizeTextBoxSwift()

class ViewController: UIViewController, UITextFieldDelegate {
    
    var handleLR: HandleView?
    var handleUL: HandleView?
    var handleUR: HandleView?
    var handleLL: HandleView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tb = ResizeTextBoxSwift(frame: CGRectMake(100, 50, 100, 23))
        tb.text = "TEST"
        tb.textAlignment = .Center
        tb.delegate = self
        tb.layer.borderWidth = 2
        tb.layer.borderColor = UIColor.darkGrayColor().CGColor
        view.addSubview(tb)
        
        view.backgroundColor = .lightGrayColor()
        
        //position must be either 'LR', 'UL', 'UR', or 'LL'
        handleLR = HandleView(position: "LR")
        handleUL = HandleView(position: "UL")
        handleUR = HandleView(position: "UR")
        handleLL = HandleView(position: "LL")
        
        for v in handleViews {
            tb.addSubview(v)
            v.updatePosition(tb.frame)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool { //just for the sake of hiding the keyboard
        textField.resignFirstResponder()
        return true
    }
}

class HandleView: UIView { //resizing handles - UI gadget, not necessary
    
    var position = ""
    
    convenience init(position: String) {
        self.init()
        self.frame.size = CGSizeMake(30, 30)
        self.backgroundColor = .whiteColor()
        self.layer.borderColor = UIColor.grayColor().CGColor
        self.layer.borderWidth = 1
        self.position = position
        
        handleViews.append(self)
    }
    
    func updatePosition(frame: CGRect) { 
        switch self.position {
        case "LR":
            self.center = CGPointMake(frame.width, frame.height)
        case "UL":
            self.center = CGPointMake(0, 0)
        case "UR":
            self.center = CGPointMake(frame.width, 0)
        case "LL":
            self.center = CGPointMake(0, frame.height)
        default:
            print("A handle's position was set incorrectly. Possibly positions: 'LR', 'UL', 'UR', or 'LL'")
        }
    }
}

class ResizeTextBoxSwift: ResizeTextBox {
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesMoved(touches, withEvent: event)
        for v in handleViews {
            v.updatePosition(newRect)
        }
    }
}














