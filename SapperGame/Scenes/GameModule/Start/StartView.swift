//
//  StartView.swift
//  SapperGame
//
//  Created by pavel mishanin on 06.04.2022.
//

import UIKit

protocol StartViewDelegate: AnyObject {
    func onLevelButtonTapped(state: LevelsState)
}

enum LevelsState {
    case beginner
    case middle
    case advanced
}

final class StartView: UIView {
    
    weak var delegate: StartViewDelegate?
    private let advancedButton = CustomButton()
    private let beginnerButton = CustomButton()
    private let middleButton = CustomButton()
    private let vStackView = CustomStackView()
    
    init() {
        super.init(frame: CGRect())
        configureAdvancedButton()
        configureView()
        configureLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureAdvancedButton() {
        advancedButton.customButton(title: "Advanced", action: #selector(advancedButtonTapped), view: self, color: .red)
        
        middleButton.customButton(title: "Middle", action: #selector(middleButtonTapped), view: self, color: .blue)
        
        beginnerButton.customButton(title: "Beginner", action: #selector(beginnerButtonTapped), view: self, color: .green)
    }
   
    @objc private func advancedButtonTapped() {
        delegate?.onLevelButtonTapped(state: .advanced)
    }
    
    @objc private func middleButtonTapped() {
        delegate?.onLevelButtonTapped(state: .middle)
    }
    
    @objc private func beginnerButtonTapped() {
        delegate?.onLevelButtonTapped(state: .beginner)
    }
    
    private func configureView() {
        backgroundColor = .white
        
        addSubview(vStackView)
        vStackView.addArrangedSubviews([advancedButton, middleButton, beginnerButton])
    }
    
    private func configureLayoutConstraints() {
        NSLayoutConstraint.activate([
            
            vStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 40),
            vStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -40),
            vStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            advancedButton.widthAnchor.constraint(equalTo: vStackView.widthAnchor),
            advancedButton.heightAnchor.constraint(equalToConstant: 60),
            
            middleButton.widthAnchor.constraint(equalTo: vStackView.widthAnchor),
            middleButton.heightAnchor.constraint(equalToConstant: 60),
            
            beginnerButton.widthAnchor.constraint(equalTo: vStackView.widthAnchor),
            beginnerButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}
