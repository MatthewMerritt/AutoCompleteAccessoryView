//
//  AutoCompleteView.swift
//  LineChartExample
//
//  Created by Matthew Merritt on 3/23/20.
//  Copyright © 2020 Matthew Merritt. All rights reserved.
//

import UIKit
import EasyClosure

public class AutoCompleteAccessoryView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var collectionView: UICollectionView!

    private let cellId = "CellId1"

    public var searchStrings: [String] = []

    private var displayStrings: [String] {
        get {
            return self.typed == "" ? searchStrings : self.searchStrings.filter { $0.range(of: self.typed, options: .caseInsensitive) != nil }
        }
    }

    public var typed: String = "" {
        didSet {
            collectionView.performBatchUpdates({
                collectionView.reloadSections(IndexSet(arrayLiteral: 0))
            }, completion: nil)
        }
    }

    var completion: ((_ status: Bool) -> Void)?

    var leftButtonText: String = "X" {
        didSet {
            self.leftButton.setTitle(self.leftButtonText, for: .normal)
        }
    }

    let leftButton: UIButton = {
        let button = UIButton()

        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("X", for: .normal)
        button.setTitleColor(.blue, for: .normal)

        button.setTitleColor(.red, for: .highlighted)

        button.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)

        return button
    }()


    let verticalRuleLeft: UIView = {
        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false

        view.backgroundColor = UIColor(red: 195.0/255.0, green: 196.0/255.0, blue: 201.0/255.0, alpha: 0.75)

        return view
    }()


    public var textField: UITextField?

    public override init(frame: CGRect) {
        super.init(frame: frame)
    }

    public convenience init(collectionViewLayout layout: UICollectionViewLayout) {
        self.init(frame: .zero)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collectionView.frame = CGRect.zero
        collectionView.collectionViewLayout = layout

        setup()
    }

    public convenience init() {
        self.init(frame: .zero)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

        setup()
    }

    public convenience init(searchStrings: [String]) {
        self.init(frame: .zero)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

        setup()

        self.searchStrings = searchStrings
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func setup() {

        frame.size.height = 44

        let blurEffect = UIBlurEffect(style: .prominent)

        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurredEffectView.frame = bounds

        backgroundColor = .clear
        collectionView.backgroundColor = .clear

        autoresizingMask = [.flexibleWidth]

        addSubview(blurredEffectView)

        collectionView.translatesAutoresizingMaskIntoConstraints = false

        blurredEffectView.contentView.addSubview(leftButton)
        blurredEffectView.contentView.addSubview(verticalRuleLeft)
        blurredEffectView.contentView.addSubview(collectionView)

        leftButton.leftAnchor.constraint(equalTo: blurredEffectView.contentView.leftAnchor, constant: 5).isActive = true
        leftButton.widthAnchor.constraint(equalTo: blurredEffectView.contentView.heightAnchor, constant: -25).isActive = true
        leftButton.heightAnchor.constraint(equalTo: blurredEffectView.contentView.heightAnchor, constant: -10).isActive = true
        leftButton.centerYAnchor.constraint(equalTo: blurredEffectView.contentView.centerYAnchor).isActive = true

        verticalRuleLeft.leftAnchor.constraint(equalTo: leftButton.rightAnchor, constant: 8).isActive = true
        verticalRuleLeft.widthAnchor.constraint(equalToConstant: 1).isActive = true
        verticalRuleLeft.heightAnchor.constraint(equalTo: blurredEffectView.contentView.heightAnchor, constant: -20).isActive = true
        verticalRuleLeft.centerYAnchor.constraint(equalTo: blurredEffectView.contentView.centerYAnchor).isActive = true

        collectionView.leftAnchor.constraint(equalTo: verticalRuleLeft.rightAnchor, constant: 10).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: 10).isActive = true
        collectionView.heightAnchor.constraint(equalTo: blurredEffectView.contentView.heightAnchor, constant: 0).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: blurredEffectView.contentView.centerYAnchor).isActive = true

        collectionView.register(AutoCompleteAccessoryCell.self, forCellWithReuseIdentifier: cellId)
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).scrollDirection = .horizontal

        collectionView.delegate = self
        collectionView.dataSource = self

    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayStrings.count
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            // dataArary is the managing array for your UICollectionView.

        let item = displayStrings[indexPath.row]
        var itemSize = item.size(withAttributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)
        ])
        itemSize.height = 44
        itemSize.width += 20

        return itemSize
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AutoCompleteAccessoryCell

        cell.backgroundColor = .clear
        cell.label.text = displayStrings[indexPath.row]

        cell.seperator.backgroundColor = indexPath.row == displayStrings.count - 1 ? .clear : .lightGray
        cell.autoCompletView = self
        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let text = (collectionView.cellForItem(at: indexPath) as! AutoCompleteAccessoryCell).label.text {
            textField?.text = text
            typed = text
        }
    }

    @objc func cancelButtonAction(_ sender: UIButton) {
        completion?(false)
    }

}

