//
//  CustomStackView.swift
//  SapperGame
//
//  Created by pavel mishanin on 29.03.2022.
//

import UIKit

final class CustomStackView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStackView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureStackView() {
        self.axis = .vertical
        self.alignment = .center
        self.distribution = .fillProportionally
        self.spacing = 25
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
