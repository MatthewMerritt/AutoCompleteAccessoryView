//
//  ViewController.swift
//  AutoCompleteAccessoryView
//
//  Created by MatthewMerritt on 03/24/2020.
//  Copyright (c) 2020 MatthewMerritt. All rights reserved.
//

import UIKit
import AutoCompleteAccessoryView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func actionButtonAction(_ sender: UIButton) {

        let ac = UIAlertController(title: "StrengthRep Exercise", message: nil, preferredStyle: .alert)

        ac.addTextField { textField in

            textField.placeholder = "Enter Name"
            textField.autocapitalizationType = .words
            textField.clearButtonMode = .whileEditing

            let autoCompleteView = AutoCompleteAccessoryView(searchStrings: ["Apple", "Apple Sauce", "Pineapple", "Orange", "MoFu"])

            autoCompleteView.textField = textField

            textField.inputAccessoryView = autoCompleteView

            textField.on.textChange { string in
                autoCompleteView.typed = string
            }

        }

        ac.addTextField { textField in

            textField.placeholder = "Enter Description"
            textField.autocapitalizationType = .words
            textField.clearButtonMode = .whileEditing

            let autoCompleteView = AutoCompleteAccessoryView()

            autoCompleteView.searchStrings = ["iPhone", "iPad", "iPod", "AirPod", "iMac", "HomePod"]
            autoCompleteView.textField = textField

            textField.inputAccessoryView = autoCompleteView

            textField.on.textChange { string in
                autoCompleteView.typed = string
            }

        }

        ac.addTextField { textField in
            textField.placeholder = "Enter Description"
            textField.autocapitalizationType = .words
            textField.clearButtonMode = .whileEditing

            textField.inputAccessoryView = PlaceHolderAccessoryView(placeHolder: "Enter Text") { status in
                print("Status: \(status)")
            }

        }

        ac.message = "Add this CardioRep Name"

        let submitAction = UIAlertAction(title: "Add", style: .default) { [unowned ac] _ in
            let nameField = ac.textFields![0]
            let descriptionField = ac.textFields![1]
            // do something interesting with "answer" here

            print("nameField: \(nameField.text!)")
            print("descriptionField: \(descriptionField.text!)")

            self.dismiss(animated: true) {}
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { _ in
            self.dismiss(animated: true) {}
        }

        ac.addAction(cancelAction)
        ac.addAction(submitAction)

        DispatchQueue.main.async {
            self.present(ac, animated: true) { }
        }

    }
}

