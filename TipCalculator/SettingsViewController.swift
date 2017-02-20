//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Alex Tam on 2/19/17.
//  Copyright © 2017 Alex Tam. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var settingsTipControl: UISegmentedControl!
    
    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        let savedIndex = defaults.integer(forKey: "segmentedControlIndex")
        settingsTipControl.selectedSegmentIndex = savedIndex
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func setDefaultTipPercentage(_ sender: AnyObject) {
        let defaults = UserDefaults.standard
        let selectedIndex = settingsTipControl.selectedSegmentIndex
        defaults.set(selectedIndex, forKey: "segmentedControlIndex")
        defaults.synchronize()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
