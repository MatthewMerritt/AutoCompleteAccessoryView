//
//  PlaceHolderAccessoryView.swift
//  AutoCompleteAccessoryView
//
//  Created by Matthew Merritt on 4/21/20.
//

import UIKit

public class PlaceHolderAccessoryView: UIView {

    public var completion: ((_ status: Bool) -> Void)?

    public var leftButtonText: String = "X" {
        didSet {
            self.leftButton.setTitle(self.leftButtonText, for: .normal)
        }
    }

    public var rightButtonText: String = "Ok" {
        didSet {
            self.rightButton.setTitle(self.rightButtonText, for: .normal)
        }
    }

    public let label: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = UIFont.preferredFont(forTextStyle: .title2)

        return label
    }()

    let rightButton: UIButton = {
        let button = UIButton()

        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Ok", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)

        button.setTitleColor(.lightGray, for: .highlighted)

        button.addTarget(self, action: #selector(okButtonAction), for: .touchUpInside)

        return button
    }()

    let leftButton: UIButton = {
        let button = UIButton()

        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("X", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)

        button.setTitleColor(.systemRed, for: .highlighted)

        button.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)

        return button
    }()


    let verticalRuleLeft: UIView = {
        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false

        view.backgroundColor = UIColor(red: 195.0/255.0, green: 196.0/255.0, blue: 201.0/255.0, alpha: 0.75)

        return view
    }()

    let verticalRuleRight: UIView = {
        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false

        view.backgroundColor = UIColor(red: 195.0/255.0, green: 196.0/255.0, blue: 201.0/255.0, alpha: 0.75)

        return view
    }()


    public convenience init(placeHolder: String, completion: ((Bool) -> Void)? = nil) {
        self.init(frame: CGRect.zero)

        self.completion = completion

        setup()

        label.text = placeHolder
    }

    func setup() {
        let blurEffect = UIBlurEffect(style: .prominent)

        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurredEffectView.frame = bounds

        backgroundColor = .clear
        addSubview(blurredEffectView)

        autoresizingMask = [.flexibleWidth]

        blurredEffectView.contentView.addSubview(label)
        blurredEffectView.contentView.addSubview(verticalRuleLeft)
        blurredEffectView.contentView.addSubview(leftButton)
        blurredEffectView.contentView.addSubview(verticalRuleRight)
        blurredEffectView.contentView.addSubview(rightButton)

        frame.size.height = 44

        leftButton.leftAnchor.constraint(equalTo: blurredEffectView.contentView.leftAnchor, constant: 5).isActive = true
        leftButton.widthAnchor.constraint(equalTo: blurredEffectView.contentView.heightAnchor, constant: -25).isActive = true
        leftButton.heightAnchor.constraint(equalTo: blurredEffectView.contentView.heightAnchor, constant: -10).isActive = true
        leftButton.centerYAnchor.constraint(equalTo: blurredEffectView.contentView.centerYAnchor).isActive = true

        verticalRuleLeft.leftAnchor.constraint(equalTo: leftButton.rightAnchor, constant: 8).isActive = true
        verticalRuleLeft.widthAnchor.constraint(equalToConstant: 1).isActive = true
        verticalRuleLeft.heightAnchor.constraint(equalTo: blurredEffectView.contentView.heightAnchor, constant: -20).isActive = true
        verticalRuleLeft.centerYAnchor.constraint(equalTo: blurredEffectView.contentView.centerYAnchor).isActive = true

        label.leftAnchor.constraint(equalTo: verticalRuleLeft.rightAnchor, constant: 10).isActive = true
        label.rightAnchor.constraint(equalTo: rightButton.leftAnchor, constant: 10).isActive = true
        label.heightAnchor.constraint(equalTo: blurredEffectView.contentView.heightAnchor, constant: -10).isActive = true
        label.centerYAnchor.constraint(equalTo: blurredEffectView.contentView.centerYAnchor).isActive = true

        verticalRuleRight.rightAnchor.constraint(equalTo: rightButton.leftAnchor, constant: 8).isActive = true
        verticalRuleRight.widthAnchor.constraint(equalToConstant: 1).isActive = true
        verticalRuleRight.heightAnchor.constraint(equalTo: blurredEffectView.contentView.heightAnchor, constant: -20).isActive = true
        verticalRuleRight.centerYAnchor.constraint(equalTo: blurredEffectView.contentView.centerYAnchor).isActive = true

        rightButton.rightAnchor.constraint(equalTo: blurredEffectView.contentView.rightAnchor, constant: 8).isActive = true
        rightButton.widthAnchor.constraint(equalTo: blurredEffectView.contentView.heightAnchor, constant: 15).isActive = true
        rightButton.heightAnchor.constraint(equalTo: blurredEffectView.contentView.heightAnchor, constant: -10).isActive = true
        rightButton.centerYAnchor.constraint(equalTo: blurredEffectView.contentView.centerYAnchor).isActive = true

    }

    @objc func okButtonAction(_ sender: UIButton) {
        completion?(true)
    }

    @objc func cancelButtonAction(_ sender: UIButton) {
        completion?(false)
    }

}

