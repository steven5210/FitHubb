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
        getActivity()
    }
    func getActivity() {
        Alamofire.request(.GET, "https://fithubb.herokuapp.com/api/activities").responseJSON { response in

            if let JSON = response.result.value {
                for var i = 0; i < JSON.count; ++i {
                    if let activity = JSON[i]{
                        if let kind = (activity["kind"])! {
                        self.activityDataSource.append(String(kind))
                        self.activityPicker.reloadAllComponents()
                        }
                        }
                    }
                }
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