//
//  GridTemplate.swift
//  Amondo
//
//  Created by developer@amondo.com on 3/16/19.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

class GridTemplate {
    
    var imprint: AMDImprintItem!
    var items: [GridItem]!
    var orderedItems: [AMDAsset]!
    
    init(items: [GridItem], ordered: [AMDAsset]) {
        self.items = items
        self.orderedItems = ordered
    }
    
    class func generate(imprint: AMDImprintItem) -> GridTemplate {
        var items = [GridItem]()
        var sortedItems = [AMDAsset]()
        var orderedItems = [AMDAsset]()
        
        let width = UIScreen.main.bounds.width-8
        let heightSquare = width/2
        let heightPortrait = width/2+30
        let heightScroller = width-30
        
        let itemsWithOrientation: [AMDAsset] = imprint.items.map{
            (asset) in
            if let file = asset.aobject!["file"] as? [String: Any] {
                if file["height"] != nil {
                    let height: Int = file["height"] as! Int
                    let width: Int = file["width"] as! Int
                    asset.isTwitterStatus = asset.statusType
                    if asset.isTwitterStatus || asset.type == "url" {
                        if height == width {
                            asset.orientation = .square
                        } else if height > width {
                            asset.orientation = .portrait
                        } else {
                            asset.orientation = .landscape
                        }
                    } else {
                        asset.orientation = height == width ? .square : .portrait
                    }
                    if items.count < 4 && !asset.isTwitterStatus && asset.orientation == .square {
                        orderedItems.append(asset)
                        asset.offsetY = 0
                        items.append(GridItem(content: asset, type: .square, height: heightSquare, width: heightSquare))
                    }
                } else {
                    asset.orientation = .none
                }

            }
            return asset
            }.filter { (asset) -> Bool in
                asset.orientation != .none
        }
        if items.count == 4 {
            items.forEach { (item) in
                if let asset = item.content as? AMDAsset {
                    sortedItems.append(asset)
                }
            }
        } else {
            items.removeAll()
        }
        
        let articles = itemsWithOrientation.filter({$0.type == "url" || $0.type == "status" || $0.type == "photo" && $0.isTwitterStatus == true || $0.type == "video" && $0.isTwitterStatus == true})
        var articlesScroller: [GridItem] = [GridItem]()
        
        var articlesTemp: [AMDAsset] = [AMDAsset]()
        var hasArticles = false
        articles.forEach { (asset) in
            orderedItems.append(asset)
            articlesTemp.append(asset)
            asset.offsetY = heightScroller
            hasArticles = true
        }
        
        if articlesTemp.count > 0 {
            hasArticles = true
            articlesScroller.append(GridItem(content: articlesTemp, type: .scroller, height: heightScroller, width: heightScroller))
        }
        
        if articlesScroller.count > 0 {
            items.append(articlesScroller[0])
            articlesScroller.remove(at: 0)
        }
        
        var events = itemsWithOrientation.filter { !sortedItems.contains($0) && !articles.contains($0)}
        var grouppedEvents = [AMDAsset]()
        
        repeat {
            let newGrouppedEvents = GridTemplate.groupAssets(assets: events, groupped: grouppedEvents)
            events = events.filter { (asset) -> Bool in
                !newGrouppedEvents.contains(asset)
            }
            grouppedEvents.append(contentsOf: newGrouppedEvents)
            if (events.count == 1) {
                grouppedEvents.append(events[0])
                events.remove(at: 0)
            }
        } while grouppedEvents.count < events.count
        
        var previousCellsYOffset = [CGFloat](repeating: 2, count: 2)
        var currentColumnIndex: Int = 0
        grouppedEvents.forEach { (asset) in
            let height = asset.orientation == .portrait ? heightPortrait : heightSquare
            let minOffsetInfo = GridTemplate.minYOffsetFrom(array: previousCellsYOffset)
            currentColumnIndex = minOffsetInfo.index
            if let maxOffset = previousCellsYOffset.max() {
                asset.offsetY = maxOffset < CGFloat(10.0) && hasArticles ? heightScroller : previousCellsYOffset.max()! + heightScroller
                asset.offsetY += height + 4
            }
            previousCellsYOffset[currentColumnIndex] = height + previousCellsYOffset[currentColumnIndex] + 4
            orderedItems.append(asset)
        }
        
        items.append(GridItem(content: grouppedEvents, type: .group, height: previousCellsYOffset.max()! +  2, width: heightScroller))
        
        return GridTemplate(items: items, ordered: orderedItems)
    }
    
    class func minYOffsetFrom(array: [CGFloat]) -> (offset: CGFloat, index: Int) {
        let minYOffset = array.min()!
        let minIndex = array.index(of: minYOffset)!
        
        return (minYOffset, minIndex)
    }
    
    private class func groupAssets(assets: [AMDAsset], groupped: [AMDAsset]) -> [AMDAsset] {
        var eventsPortrait = assets.filter { $0.orientation == .portrait }
        var eventsSquare = assets.filter { $0.orientation == .square }
        
        var tempEvents: [AMDAsset] = [AMDAsset]()
        var previousOrientation = groupped.count > 0 ? groupped[groupped.count-1].orientation : .portrait
        
        if assets.count == eventsSquare.count {
            if eventsSquare.count % 2 == 0 {
                return eventsSquare
            }
            return Array(eventsSquare.dropLast())
        }
        
        if assets.count == eventsPortrait.count {
            if eventsPortrait.count % 2 == 0 {
                return eventsPortrait
            }
            return Array(eventsPortrait.dropLast())
        }
        
        assets.forEach { (asset) in
            if tempEvents.count == 0 {
                tempEvents.append(asset)
                previousOrientation = GridTemplate.sortAsset(asset: asset, portraits: &eventsPortrait, squares: &eventsSquare)
            } else if tempEvents.count == 1 {
                if asset.orientation != previousOrientation {
                    tempEvents.append(asset)
                    previousOrientation = GridTemplate.sortAsset(asset: asset, portraits: &eventsPortrait, squares: &eventsSquare)
                }
            } else {
                if asset.orientation != previousOrientation {
                    tempEvents.append(asset)
                    previousOrientation = GridTemplate.sortAsset(asset: asset, portraits: &eventsPortrait, squares: &eventsSquare)
                }
            }
        }
        if (tempEvents.count%2 == 0) {
            return tempEvents
        } else {
            return Array(tempEvents.dropLast())
        }
    }
    
    private class func sortAsset(asset: AMDAsset, portraits: inout[AMDAsset], squares: inout[AMDAsset]) -> AMDAsset.Orientation {
        if (asset.orientation == .portrait) {
            let index = portraits.index(of: asset)
            portraits.remove(at: index!)
            return .portrait
        } else {
            let index = squares.index(of: asset)
            squares.remove(at: index!)
            return .square
        }
    }
    
    func nextAsset(from: AMDAsset) -> AMDAsset? {
        let index = orderedItems.index(of: from)
        if index!+1 < orderedItems.count {
            return orderedItems[index!+1] as AMDAsset
        }
        
        return nil
    }
    
    func previousAsset(from: AMDAsset) -> AMDAsset? {
        let index = orderedItems.index(of: from)
        if index!-1 >= 0 {
            return orderedItems[index!-1] as AMDAsset
        }
        
        return nil
    }
}
