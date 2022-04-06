//
//  CustomButton.swift
//  SapperGame
//
//  Created by pavel mishanin on 29.03.2022.
//

import UIKit

final class CustomButton: UIButton {
    private var isCurrentOutside = false
    
    func customButton(title: String,
                      action: Selector,
                      view: UIView,
                      color: UIColor) {
        self.clipsToBounds = true
        self.layer.cornerRadius = 30
        self.layer.borderWidth = 2
        self.layer.borderColor = color.cgColor
        self.setTitle(title, for: .normal)
        self.setTitleColor(color, for: .normal)
        self.titleLabel?.font =  UIFont(name: "Helvetica", size: 25)
        self.addTarget(view, action: action, for: .touchUpInside)
        self.translatesAutoresizingMaskIntoConstraints = false
        animate()
    }
    
    private func animate() {
        self.addTarget(self, action: #selector(shrinkAllowAnimation), for: .touchDown)
        self.addTarget(self, action: #selector(restoreAllowAnimation), for: .touchUpInside)
        self.addTarget(self, action: #selector(restoreAllowAnimation), for: .touchUpOutside)
        self.addTarget(self, action: #selector(restore), for: .touchDragOutside)
        self.addTarget(self, action: #selector(shrink), for: .touchDragInside)
    }
    
    @objc func shrinkAllowAnimation(){
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.6),
                       initialSpringVelocity: CGFloat(25.0),
                       options: [.curveEaseOut, .allowUserInteraction],
                       animations: {
                        self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                       })
    }
    
    @objc func restoreAllowAnimation(){
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.6),
                       initialSpringVelocity: CGFloat(10.0),
                       options: [.curveEaseIn, .allowUserInteraction],
                       animations: {
                        self.transform = CGAffineTransform.identity
                       })
    }
    
    @objc func shrink(){
        if isCurrentOutside == true{
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: CGFloat(0.6),
                           initialSpringVelocity: CGFloat(15.0),
                           options: [.curveEaseOut],
                           animations: {
                            self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                           }, completion: {_ in self.isCurrentOutside = false})
        }
    }
    
    @objc func restore(){
        if isCurrentOutside == false{
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: CGFloat(0.6),
                           initialSpringVelocity: CGFloat(15.0),
                           options: [.curveEaseIn],
                           animations: {
                            self.transform = CGAffineTransform.identity
                           },completion: {_ in self.isCurrentOutside = true})
        }
    }
    
    override var isHighlighted: Bool {
        didSet { if isHighlighted { isHighlighted = false } }
    }
}
