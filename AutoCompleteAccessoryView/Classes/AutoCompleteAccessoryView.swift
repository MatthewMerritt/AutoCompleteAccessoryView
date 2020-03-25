//
//  AutoCompleteView.swift
//  LineChartExample
//
//  Created by Matthew Merritt on 3/23/20.
//  Copyright © 2020 Matthew Merritt. All rights reserved.
//

import UIKit
import EasyClosure

public class AutoCompleteAccessoryView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    private let cellId = "CellId1"

    public var searchStrings: [String] = []

    private var displayStrings: [String] {
        get {
            return self.typed == "" ? searchStrings : self.searchStrings.filter { $0.range(of: self.typed, options: .caseInsensitive) != nil }
        }
    }

    public var typed: String = "" {
        didSet {
            performBatchUpdates({
                reloadSections(IndexSet(arrayLiteral: 0))
            }, completion: nil)
        }
    }

    public var textField: UITextField?

    public convenience init(collectionViewLayout layout: UICollectionViewLayout) {
        self.init(frame: CGRect.zero, collectionViewLayout: layout)
        setup()
    }

    public convenience init() {
        self.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        setup()
    }

    public convenience init(searchStrings: [String]) {
        self.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        setup()

        self.searchStrings = searchStrings
    }


    private func setup() {

        let blurEffect = UIBlurEffect(style: .prominent)

        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurredEffectView.frame = bounds

        backgroundColor = .clear
        backgroundView = blurredEffectView

        autoresizingMask = [.flexibleWidth]

        register(AutoCompleteAccessoryCell.self, forCellWithReuseIdentifier: cellId)
        (collectionViewLayout as! UICollectionViewFlowLayout).scrollDirection = .horizontal

        delegate = self
        dataSource = self

        frame.size.height = 44
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

}

