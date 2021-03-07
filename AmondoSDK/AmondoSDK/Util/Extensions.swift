//
//  Extensions.swift
//  Amondo
//
//  Created by Timothy Whiting on 08/11/2016.
//  Copyright © 2016 Arcopo. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

extension Optional {
    static func isNil(_ object: Wrapped) -> Bool {
        switch object as Any {
        case Optional<Any>.none:
            return true
        default:
            return false
        }
    }
}

extension UIView {
    func addShadows(_ x: CGFloat, y: CGFloat, alpha: Float, radius: CGFloat) {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = alpha
        self.layer.shadowOffset = CGSize(width: x, height: y)
        self.layer.shadowRadius = radius
    }
}

extension CALayer {
    var borderUIColor: UIColor {
        set {
            self.borderColor = newValue.cgColor
        }

        get {
            return UIColor(cgColor: self.borderColor!)
        }
    }
}

extension String {

    func heightForView(_ font: UIFont, width: CGFloat) -> CGFloat {
        let text = self
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text

        label.sizeToFit()
        return label.frame.height
    }

    func widthForView(_ font: UIFont, height: CGFloat) -> CGFloat {
        let text = self
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat.greatestFiniteMagnitude, height: height))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text

        label.sizeToFit()
        return label.frame.width
    }

}

extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}

extension String {
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}

extension Date {
    func stringDate(_ dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {

        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle

        let string = formatter.string(from: self)

        return string
    }

    func postgrestDate() -> String {

        let formatter = DateFormatter()
        formatter.dateFormat="yyyy-MM-dd'T'HH:mm:ss"

        let string = formatter.string(from: self)

        return string
    }

}

extension String {

    func dateFromPostgresString() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        var date = formatter.date(from: self)
        if date == nil {
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            date = formatter.date(from: self)
            if date == nil {
                return Date()
            }
        }
        return date!
    }
}

extension UIImage {
    func grayscaleImage() -> UIImage? {
        return self
        return newBlur(self)//applyBlurEffect(self)

        let brightness: Double = 0.0
        let contrast: Double = 1.0

        if let ciImage = CoreImage.CIImage(image: self, options: nil) {
            let paramsColor: [String: AnyObject] = [ kCIInputBrightnessKey: NSNumber(value: brightness as Double),
                                                     kCIInputContrastKey: NSNumber(value: contrast as Double),
                                                     kCIInputSaturationKey: NSNumber(value: 0.0 as Double) ]
            let grayscale = ciImage.applyingFilter("CIColorControls", parameters: paramsColor)

            let processedCGImage = CIContext().createCGImage(grayscale, from: grayscale.extent)
            return UIImage(cgImage: processedCGImage!, scale: self.scale, orientation: self.imageOrientation)
        }
        return nil
    }

    func newBlur(_ image: UIImage) -> UIImage {
        let blurRadius = 20
        let ciimage: CoreImage.CIImage = CoreImage.CIImage(image: image)!

        // Added "CIAffineClamp" filter
        let affineClampFilter = CIFilter(name: "CIAffineClamp")!
        affineClampFilter.setDefaults()
        affineClampFilter.setValue(ciimage, forKey: kCIInputImageKey)
        let resultClamp = affineClampFilter.value(forKey: kCIOutputImageKey)

        // resultClamp is used as input for "CIGaussianBlur" filter
        let filter: CIFilter = CIFilter(name: "CIGaussianBlur")!
        filter.setDefaults()
        filter.setValue(resultClamp, forKey: kCIInputImageKey)
        filter.setValue(blurRadius, forKey: kCIInputRadiusKey)

        let ciContext = CIContext(options: nil)
        let result = filter.outputImage!
        let cgImage = ciContext.createCGImage(result, from: ciimage.extent) // changed to ciiimage.extend

        let finalImage = UIImage(cgImage: cgImage!)
        return finalImage
    }
    func applyBlurEffect(_ image: UIImage) -> UIImage {

        let imageToBlur = CoreImage.CIImage(image: image, options: nil)
        let context = CIContext(options: nil)
        let blurfilter = CIFilter(name: "CIGaussianBlur")
        blurfilter!.setValue(imageToBlur, forKey: "inputImage")
        blurfilter?.setValue(10, forKey: "inputRadius")
        let resultImage = blurfilter!.outputImage

        if let cgimg = context.createCGImage(resultImage!, from: imageToBlur!.extent) {
            let processedImage = UIImage(cgImage: cgimg)
            return processedImage
            // do something interesting with the processed image
        }

        let blurredImage = UIImage(ciImage: resultImage!)
        return blurredImage

    }
}

extension UIView {
    func rotateByAngle(_ angle: Double) {
        self.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
    }
}

class MenuCellTapGestureRecognizer: UITapGestureRecognizer {
    var indexPath: IndexPath!
    var collectionView: UICollectionView!
}

extension UIView {

    func pb_takeSnapshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)

        drawHierarchy(in: self.bounds, afterScreenUpdates: true)

        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }

}

extension UITextView {
    func resizeFont() -> CGFloat {

        let startFontSize = 70.0
        let minFontSize = 4.0

        //      self.frame.size.height=8

        self.clipsToBounds = false

        self.attributedText = self.attStringof(size: 70)

        self.contentInset.top = 0

        var height = self.text.heightForView(self.attFont(), width: self.bounds.width)

        for fontSize in stride(from: startFontSize, through: minFontSize, by: -1) {

            self.attributedText = self.attStringof(size: CGFloat(fontSize))
            height = self.text.heightForView(self.attFont(), width: self.bounds.width)

            var maxWord = ""
            for word in self.text.words {
                if word.characters.count > maxWord.characters.count {
                    maxWord = word
                }
            }
            let wordwidth = maxWord.widthForView(self.attFont(), height: self.attFont().lineHeight + 6)

            if (height < self.bounds.height) && (wordwidth < self.bounds.width) {

                self.attributedText = self.attStringof(size: CGFloat(fontSize) - 5)

                return height
                break

            }
        }

        return height

    }

    func attStringof(size: CGFloat) -> NSAttributedString {
        let dinFont = UIFont(name: "DINPro-CondensedBold", size: size)!
        let myAttributes = [NSAttributedString.Key.font: dinFont, NSAttributedString.Key.foregroundColor: UIColor.white]
        let attrString = NSAttributedString(string: self.text, attributes: myAttributes)
        return attrString
    }

    func attFont() -> UIFont {
        var attributes = self.attributedText.attributes(at: 0, longestEffectiveRange: nil, in: NSRange(location: 0, length: attributedText.length))
        let tfont = attributes[NSAttributedString.Key.font] as! UIFont
        return tfont
    }

}

extension String {
    func attStringof(size: CGFloat) -> NSAttributedString {
        let dinFont = UIFont(name: "DINPro-CondensedBold", size: size)!
        let myAttributes = [NSAttributedString.Key.font: dinFont, NSAttributedString.Key.foregroundColor: UIColor.white]
        let attrString = NSAttributedString(string: self, attributes: myAttributes)
        return attrString
    }

}

extension String {
    var words: [String] {
        return components(separatedBy: .punctuationCharacters)
            .joined()
            .components(separatedBy: .whitespaces)
            .filter { !$0.isEmpty }
    }
}

extension String {

    func highlight(_ highlight: String) -> NSMutableAttributedString {

        let range = (self as NSString).range(of: highlight)

        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 0.00, green: 0.75, blue: 0.79, alpha: 1.0), range: range)

        return attributedString
    }
    
    func heightNeeded(maxWidth: CGFloat, font: UIFont) -> CGFloat {
        let size = CGSize(width: maxWidth, height: .greatestFiniteMagnitude)
        let rect = self.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(rect.height)
    }
}

public enum Direction: String {
    case Up = "up"
    case Down = "down"
    case Left = "left"
    case Right = "right"

    public var isX: Bool { return self == .Left || self == .Right }
    public var isY: Bool { return !isX }
}

public extension UIPanGestureRecognizer {
    var direction: Direction? {
        let velocity = self.velocity(in: view)
        let vertical = abs(velocity.y) > abs(velocity.x)
        switch (vertical, velocity.x, velocity.y) {
        case (true, _, let y) where y > 0: return .Down
        case (true, _, let y) where y < 0: return .Up
        case (false, let x, _) where x > 0: return .Right
        case (false, let x, _) where x < 0: return .Left
        default: return nil
        }
    }
}

extension UIView {
    func animateOpacity(alpha:CGFloat,duration:Double){
        UIView.animate(withDuration: duration) {
            self.alpha=alpha
        }
    }
}

extension StringProtocol {
    var firstUppercased: String {
        guard let first = first else { return "" }
        return String(first).uppercased() + dropFirst()
    }
    var firstCapitalized: String {
        guard let first = first else { return "" }
        return String(first).capitalized + dropFirst()
    }
}
