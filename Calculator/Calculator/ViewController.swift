//
//  ViewController.swift
//  Calculator
//
//  Created by Jonatas Saraiva on 04/02/17.
//  Copyright © 2017 jonatas saraiva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var userIsInTheMeddleOfTyping = false;
    
    @IBOutlet weak var display: UILabel!
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if self.userIsInTheMeddleOfTyping {
            let textCurrentInDisplay = self.display.text!
            self.display.text = textCurrentInDisplay + digit
        }
        else {
            self.display.text = digit
        }
        
        self.userIsInTheMeddleOfTyping = true;
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        self.userIsInTheMeddleOfTyping = false
        if let mathematicalSymbol = sender.currentTitle {
            if mathematicalSymbol == "π" {
                self.display.text = String(M_PI)
            }
        }
    }

}

