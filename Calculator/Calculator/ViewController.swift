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

    private var userIsInTheMeddleOfTyping = false;
    
    private var brain = Brain()
    
    private var displayValue: Double {
        get {
            return Double(self.display.text!)!
        }
        
        set {
            self.display.text = String(newValue)
        }
    }
    
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
        if self.userIsInTheMeddleOfTyping {
            self.brain.setOperand(operand: self.displayValue)
            self.userIsInTheMeddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            self.brain.performOperation(symblo: mathematicalSymbol)
        }
        
        self.displayValue = self.brain.result
    }

}

