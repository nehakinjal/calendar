//
//  Circle.swift
//  Calendar Lite
//
//  Created by Neha Dalal on 8/27/18.
//  Copyright © 2018 Neha Dalal. All rights reserved.
//

import UIKit

@IBDesignable public class Circle: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
        
    @IBInspectable public var fillColor:   UIColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)  { didSet { shapeLayer.fillColor = fillColor.cgColor } }
    @IBInspectable public var strokeColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)  { didSet { shapeLayer.strokeColor = strokeColor.cgColor } }
    @IBInspectable public var lineWidth:   CGFloat = 0   { didSet { setNeedsLayout() } }
    
    lazy private var shapeLayer: CAShapeLayer = {
        [unowned self] in
        let _shapeLayer = CAShapeLayer()
        _shapeLayer.fillColor = self.fillColor.cgColor
        _shapeLayer.strokeColor = self.strokeColor.cgColor
        self.layer.insertSublayer(_shapeLayer, at: 0)
        return _shapeLayer
    }()
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = (min(bounds.size.width, bounds.size.height) - lineWidth) / 2
        shapeLayer.path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: .pi * 2, clockwise: true).cgPath
        shapeLayer.lineWidth = lineWidth
    }
    

}
