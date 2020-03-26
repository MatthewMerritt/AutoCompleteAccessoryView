//
//  AutoCompleteCell.swift
//  LineChartExample
//
//  Created by Matthew Merritt on 3/23/20.
//  Copyright © 2020 Matthew Merritt. All rights reserved.
//

import UIKit
import EasyClosure

public class AutoCompleteAccessoryCell: UICollectionViewCell {

    public weak var autoCompletView: AutoCompleteAccessoryView?

    public let label: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false

        label.textAlignment = .left

        return label
    }()

    public let seperator: UIView = {
        let lineView = UIView(frame: .zero)

        lineView.backgroundColor = .gray

        lineView.translatesAutoresizingMaskIntoConstraints = false

        return lineView

    }()


    public override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(label)

        label.textColor = .systemBlue

        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        addSubview(seperator)

        seperator.widthAnchor.constraint(equalToConstant: 1).isActive = true
        seperator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 3).isActive = true
        seperator.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        seperator.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true

    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override var isHighlighted: Bool {
        didSet {
            if self.isHighlighted {
                // Your customized animation or add a overlay view
                label.textColor = .darkText
                autoCompletView?.isScrollEnabled = false

            } else {
                // Your customized animation or remove overlay view
                label.textColor = .systemBlue
                autoCompletView?.isScrollEnabled = true
            }
        }
    }

}
