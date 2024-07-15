//
//  UILabel+.swift
//  Weather
//
//  Created by dopamint on 7/12/24.
//

import UIKit

extension UILabel {
    
    func makeIconLabel(with symbolName: String, text: String) {
        let attributedString = NSMutableAttributedString(string: "")
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: symbolName)?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        attributedString.append(NSAttributedString(attachment: imageAttachment))
        attributedString.append(NSAttributedString(string: text))
        self.attributedText = attributedString
    }
}
