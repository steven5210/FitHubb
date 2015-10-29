//
//  createEventViewController.swift
//  FitHubb
//
//  Created by Steven Huynh on 10/29/15.
//  Copyright © 2015 Steven Huynh. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class createEventViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    @IBOutlet weak var eventNameLabel: UITextField!
    @IBOutlet weak var locationLabel: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var activityPicker: UIPickerView!
    var activityDataSource = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityPicker.dataSource = self
        self.activityPicker.delegate = self
        Alamofire.request(.GET, "https://fithubb.herokuapp.com/api/activities").responseJSON { response in
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
//        activityDataSource.append()
        }
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return activityDataSource.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return activityDataSource[row]
    }
}
