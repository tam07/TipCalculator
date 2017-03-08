//
//  ViewController.swift
//  TipCalculator
//
//  Created by Alex Tam on 2/4/17.
//  Copyright © 2017 Alex Tam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    let formatter = NumberFormatter()
    let defaults = UserDefaults.standard
    let SELECTED_INDEX = "segmentedControlIndex"
    let TIMESTAMP_KEY = "billTS"
    let BILL_KEY = "bill"
    let NUM_MINUTES = 10
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    // called once
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load")
        
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        
        setBill()
        billField.becomeFirstResponder()
    }
    
    // called when the view will appear(multiple times)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        
        tipControl.selectedSegmentIndex = defaults.integer(forKey: SELECTED_INDEX)
        calculateTip(tipControl)
    }
    

    // show the previous bill amount if it's been more than a minute since it was set
    func setBill() {
        let timeNow = Date()
        let billTS = defaults.value(forKey: TIMESTAMP_KEY) as? Date ?? timeNow as Date
        if (billTS == timeNow) {
            return
        }
        let timeElapsed = timeNow.timeIntervalSince(billTS)
        print(timeElapsed)
        // if it's been over a minute since the bill was last set, clear it out
        let overTime = timeElapsed > TimeInterval(60*NUM_MINUTES)
        if (overTime) {
            billField.text = ""
        } else {
            billField.text = defaults.string(forKey: BILL_KEY)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    // I had to manually change Any to AnyObject to connect the tipControl action
    @IBAction func calculateTip(_ sender: AnyObject) {
        let tipPercentages = [0.18, 0.2, 0.25]
        
        let bill = Double(billField.text!) ?? 0

        defaults.set(Date(), forKey: TIMESTAMP_KEY)
        defaults.set(bill, forKey: BILL_KEY)
        defaults.synchronize()
        
        let index = tipControl.selectedSegmentIndex
        let tip = (bill * tipPercentages[index])
        let total = bill + tip
        
        tipLabel.text = formatter.string(from: NSNumber(value: tip))
        totalLabel.text = formatter.string(from: NSNumber(value: total))
        
        fadeInCalculations()
    }
    
    // gradually fade in the tip and total
    func fadeInCalculations() {
        self.tipLabel.alpha = 0
        self.totalLabel.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            self.tipLabel.alpha = 1
            self.totalLabel.alpha = 1
        })
    }
}
