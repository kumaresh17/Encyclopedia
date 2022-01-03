//
//  WikiButton.swift
//  Encyclopedia
//
//  Created by on 02/01/2022.
//

import UIKit
// An IBDesignable class for button

@IBDesignable class WikiButton: UIButton {

    // Allows developer to edit what colors are shown in each state
    @IBInspectable var borderColorSelected:UIColor = UIColor.purple
    @IBInspectable var borderColorDeselected:UIColor = UIColor.purple
    
    @IBInspectable var borderWidth:CGFloat = 3
    @IBInspectable var cornerRadius:CGFloat = 10
    
    // The text that's shown in each state
    @IBInspectable var selectedText:String = "More Details"
    
    // The color of text shown in each state
    @IBInspectable var textColorDeselected:UIColor = UIColor.lightGray
    @IBInspectable var textColorSelected:UIColor = UIColor.black
    
    // Sets the Active/Inactive State
    @IBInspectable var active:Bool = false
    
    // Custom Border to the UIButton
    private let border = CAShapeLayer()

    override func draw(_ rect: CGRect) {
        
        // Setup CAShape Layer (Dashed/Solid Border)
        border.lineWidth = borderWidth
        border.frame = self.bounds
        border.fillColor = nil
        border.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
        self.layer.addSublayer(border)
        
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        
        setSelected()
        // Respond to touch events by user
    }
    
    // Set the selected properties
    func setSelected() {
        border.lineDashPattern = nil
        border.strokeColor = borderColorSelected.cgColor
        self.setTitle(selectedText, for: .normal)
        self.setTitleColor(textColorSelected, for: .normal)
    }
    
}

