//
//  AuthCustomStackView.swift
//  SapperGame
//
//  Created by pavel mishanin on 31.03.2022.
//

import UIKit

final class AuthStackView: UIStackView {
    
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
        self.spacing = 20
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addArrangedSubview($0)
        }
    }
}
