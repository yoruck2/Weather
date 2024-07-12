//
//  UILabel+.swift
//  Weather
//
//  Created by dopamint on 7/12/24.
//

import UIKit

extension UILabel {
    
    func makeIconLabel(with symbolName: String, text: String) {
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: symbolName)
        let attachmentString = NSAttributedString(attachment: attachment)
        let myString = NSMutableAttributedString(string: text)
        myString.append(attachmentString)
        self.attributedText = myString
    }
}
