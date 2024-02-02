//
//  GradientView.swift
//  NewsApp
//
//  Created by Alexandra Boar on 04.01.2024.
//

import Foundation
import UIKit

class GradientView: UIView {
    
    let baseColor: UIColor = UIColor.systemBlue
    
    let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        gradientLayer.type = .axial
        gradientLayer.colors = [
            baseColor.withAlphaComponent(0.0),
            baseColor.withAlphaComponent(1)
        ].map {$0.cgColor}
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.3)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.45)
        layer.addSublayer(gradientLayer)
        self.backgroundColor = UIColor.clear

    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        if gradientLayer.frame != bounds {
            gradientLayer.frame = bounds
        }
    }
}
