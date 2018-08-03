//
//  RFPCustomButton.swift
//  RFPDemoSwift
//
//  Created by FreakOut on 2018/07/27.
//  Copyright © 2018年 FreakOut inc.,. All rights reserved.
//

import UIKit

class RFPCustomButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0.0

    @IBInspectable var borderColor: UIColor = .clear
    @IBInspectable var borderWidth: CGFloat = 0.0

    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = (cornerRadius > 0)

        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        super.draw(rect)
    }
}
