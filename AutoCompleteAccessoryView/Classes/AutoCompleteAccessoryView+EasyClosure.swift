//
//  AutoCompleteAccessoryView+EasyClosure.swift
//  AutoCompleteAccessoryView
//
//  Created by Matthew Merritt on 3/24/20.
//

import UIKit
import EasyClosure

public extension Container where Host: UITextField {

    func event(_ event: UIControl.Event, action: @escaping StringAction) {
        let target = TextFieldTarget1(host: host, event: event, textAction: action)
        targets[TextFieldTarget1.uniqueId + ".\(event.self)"] = target
    }
}

public class TextFieldTarget1: NSObject {
    static var uniqueId: String {
        get {
            return String(describing: self)
        }
    }

    var textAction: StringAction?

    required init(host: UITextField, event: UIControl.Event, textAction: @escaping StringAction) {
        super.init()

        self.textAction = textAction

        host.addTarget(self, action: #selector(anyAction(_:)), for: event)
    }

    // MARK: - Action

    @objc func anyAction(_ textField: UITextField) {
        textAction?(textField.text ?? "")
    }

}

