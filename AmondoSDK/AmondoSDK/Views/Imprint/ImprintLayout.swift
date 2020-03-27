//
//  ImprintLayout.swift
//  Amondo
//
//  Created by James Bradley on 10/05/2016.
//  Copyright © 2016 Amondo. All rights reserved.
//

import UIKit

//Jinkei'snew

class ImprintLayout: UICollectionViewLayout {

    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    var cellSpacing: CGFloat = 0.5
    var delegate: ImprintViewController!
    var currentSection = 0

    var layoutConfigs: NSDictionary?
    var availableLayoutsKeys: [String] = []
    var matchedKeyArr: [String] = []

    var beGone = false

    fileprivate var contentHeight: CGFloat {
        return delegate.collectionViewAssets!.bounds.height
    }

    fileprivate var contentWidth: CGFloat {
        return delegate.collectionViewAssets!.bounds.width
    }

    fileprivate var numberOfSections: Int {
        return delegate.sections.count
    }

    fileprivate func numberOfItems(inSection section: Int) -> Int {
        return delegate.sections[section].count
    }

    fileprivate func orientationLabels(fromSection section: Int) -> [String] {
        let amdAssets = delegate.sections[section]
        var orientationLabels = [String]()
        for amdAsset in amdAssets {
            orientationLabels.append(amdAsset.orientationLabel)
        }

        return orientationLabels
    }

    fileprivate func getAvailableLayoutsKeys(forSection section: Int) -> [String] {
        let key = String(numberOfItems(inSection: section))
        //print(section)
        //print(key)
        //print(delegate.sections)
        let layoutConfig = layoutConfigs![key] as! NSDictionary

        return layoutConfig.allKeys as! [String]
    }

    override init() {
        super.init()

        let path = Bundle.main.path(forResource: "LayoutsAll", ofType: "plist")
        layoutConfigs = NSDictionary(contentsOfFile: path!)!
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func prepare() {

        if beGone {
            return
        }

        var section = 0
        while section < numberOfSections {
            availableLayoutsKeys = getAvailableLayoutsKeys(forSection: section)
            let matchedKey = findBestMatch(forSection: section, inKeys: availableLayoutsKeys)
            matchedKeyArr = []
            //print("👻👻👻 Matched key: \(matchedKey.joined())")

            for item in 0 ..< numberOfItems(inSection: section) {
                let indexPath = IndexPath(item: item, section: section)
                let frame = tileFrameAtIndex(indexPath, matchedKey)
                let insetFrame = frame.insetBy(dx: cellSpacing, dy: cellSpacing)

                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = insetFrame

                self.cache.append(attributes)
            }

            if delegate.sections[section].isEmpty {
                delegate.sections.remove(at: section)
            } else {
                section = section + 1
            }
        }
    }

    func tileFrameAtIndex(_ indexPath: IndexPath, _ matchedKeyArr: [String]) -> CGRect {
        let inset = CGFloat(indexPath.section) * contentHeight

        var key = String(matchedKeyArr.count)
        var matchedKeyArr = matchedKeyArr

        if matchedKeyArr.isEmpty {
            key = String(numberOfItems(inSection: indexPath.section))
            matchedKeyArr = [availableLayoutsKeys[0]]
        }

        let layoutNumberConfig = layoutConfigs![key] as! NSDictionary

        let layoutTypeConfig = layoutNumberConfig.value(forKey: matchedKeyArr.joined()) as! NSArray

        let itemLayoutConfig = layoutTypeConfig[indexPath.item] as! [Double]
        let width = itemLayoutConfig[1] - itemLayoutConfig[3]
        let height = itemLayoutConfig[2] - itemLayoutConfig[0]

        let gap: CGFloat = -1

        var xgap = gap
        if indexPath.section == 0 {
            xgap = gap / 2
        }

        let rect = CGRect(
            x: (CGFloat(itemLayoutConfig[3]) * contentWidth) + xgap,
            y: (CGFloat(itemLayoutConfig[0]) * contentHeight) + gap / 2 + inset,
            width: (CGFloat(width) * contentWidth) - gap,
            height: (CGFloat(height) * contentHeight) - gap
        )

        return rect
    }

    func splitOrientationKeysIntoArr(orientationKeys: String) -> [String] {

        let letters = CharacterSet.letters
        let digits = CharacterSet.decimalDigits
        var availableKeyArr: [String] = []

        for uni in orientationKeys.unicodeScalars {
            if letters.contains(uni) {
                availableKeyArr.append(uni.description)
            } else if digits.contains(uni) {
                availableKeyArr[availableKeyArr.endIndex - 1] += uni.description
            }
        }

        return availableKeyArr
    }

    func findBestMatch(forSection section: Int, inKeys keys: [String]) -> [String] {

        availableLayoutsKeys = getAvailableLayoutsKeys(forSection: section)

        let orientationLabelsArr = orientationLabels(fromSection: section)

        //print(orientationLabelsArr.joined())

        //print(availableLayoutsKeys)

        //print(section)

        if availableLayoutsKeys.contains(orientationLabelsArr.joined()) {
            matchedKeyArr = orientationLabelsArr
            return matchedKeyArr
        }

        var matchedKey: String = ""
        var availableKeyArr: [String]

        /*
         reorder orientationLabels
         */
        for availableKey in availableLayoutsKeys {
            availableKeyArr = splitOrientationKeysIntoArr(orientationKeys: availableKey)
            for orientationLabel in orientationLabelsArr {
                if availableKeyArr.contains(orientationLabel) {
                    let index = availableKeyArr.index(of: orientationLabel)
                    availableKeyArr.remove(at: index!)
                    matchedKey = availableKey
                    continue
                } else {
                    break
                }
            }
            if availableKeyArr.isEmpty {
                matchedKeyArr = splitOrientationKeysIntoArr(orientationKeys: matchedKey)
                break
            }
        }

        var reorderedSection: [AMDAsset] = []

        for matchedKey in matchedKeyArr {
            let amdAsset = delegate.sections[section].filter({ $0.orientationLabel == matchedKey }).first
            reorderedSection.append(amdAsset!)
            let index = delegate.sections[section].index(of: amdAsset!)
            delegate.sections[section].remove(at: index!)
        }
        delegate.sections[section].append(contentsOf: reorderedSection)
        delegate.collectionViewAssets?.reloadData()
        
        return matchedKeyArr
    }

    func permute(list: [String], minStringLen: Int = 1) -> Set<String> {
        func permute(fromList: [String], toList: [String], minStringLen: Int, set: inout Set<String>) {
            if toList.count >= minStringLen {
                set.insert(toList.joined())
            }
            if !fromList.isEmpty {
                for (index, item) in fromList.enumerated() {
                    var newFrom = fromList
                    newFrom.remove(at: index)
                    permute(fromList: newFrom, toList: toList + [item], minStringLen: minStringLen, set: &set)
                }
            }
        }

        var set = Set<String>()
        permute(fromList: list, toList: [], minStringLen: minStringLen, set: &set)
        return set
    }

    func tileFrameAtIndex(_ indexPath: IndexPath) -> CGRect {

        let inset = CGFloat(indexPath.section) * contentHeight

        let key = String(numberOfItems(inSection: indexPath.section))
        let layoutNumberConfig = layoutConfigs![key] as! NSDictionary

        let accets = delegate.sections[indexPath.section]
        var keys = [String]()
        for element in accets {
            keys.append(element.orientationLabel)
        }

        //print(keys)

        let availableKeys = layoutNumberConfig.allKeys as! [String]

        let matchedKey = findBestMatch(forSection: indexPath.section, inKeys: availableKeys)

        //print(matchedKey)
        //print(matchedKey.joined())

        let layoutTypeConfig = layoutNumberConfig.value(forKey: matchedKey.joined()) as! NSArray

        let itemLayoutConfig = layoutTypeConfig[indexPath.item] as! [Double]
        let width = itemLayoutConfig[1] - itemLayoutConfig[3]
        let height = itemLayoutConfig[2] - itemLayoutConfig[0]

        let gap: CGFloat = 0
        let rect = CGRect(
            x: (CGFloat(itemLayoutConfig[3]) * contentWidth) + gap,
            y: (CGFloat(itemLayoutConfig[0]) * contentHeight) + gap + inset,
            width: (CGFloat(width) * contentWidth) - gap,
            height: (CGFloat(height) * contentHeight) - gap
        )

        return rect
    }

    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: CGFloat(delegate.collectionViewAssets!.numberOfSections-1) * contentHeight)
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let frame = tileFrameAtIndex(indexPath)

        let insetFrame = frame.insetBy(dx: cellSpacing, dy: cellSpacing)

        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attributes.frame = insetFrame

        return attributes
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()

        for attributes in cache {
            layoutAttributes.append(attributes)
        }

        return layoutAttributes
    }

}
