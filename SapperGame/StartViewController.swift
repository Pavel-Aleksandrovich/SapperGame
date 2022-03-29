//
//  File.swift
//  SapperGame
//
//  Created by pavel mishanin on 28.03.2022.
//

import UIKit

enum Levels {
    case beginner(NameType)
    case middle(NameType)
    case advanced(NameType)
    
    struct NameType {
        let numberOfBomb: Int
        let numberOfCells: CGFloat
    }
}

final class StartViewController: UIViewController {
    
    private let advancedButton = CustomButton()
    private let beginnerButton = CustomButton()
    private let middleButton = CustomButton()
    private let vStackView = CustomStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
    }
    
    private func configureLayout() {
        configureView()
        configureLayoutConstraints()
        configureAdvancedButton()
    }
    
    private func configureAdvancedButton() {
        advancedButton.customButton(title: "Advanced", action: #selector(advancedButtonTapped), view: self, color: .red)
        
        middleButton.customButton(title: "Middle", action: #selector(middleButtonTapped), view: self, color: .blue)
        
        beginnerButton.customButton(title: "Beginner", action: #selector(beginnerButtonTapped), view: self, color: .green)
    }
    
    @objc private func advancedButtonTapped() {
        createViewController(state: Levels.advanced(Levels.NameType(
                                                        numberOfBomb: 10,
                                                        numberOfCells: 10)))
    }
    
    @objc private func middleButtonTapped() {
        createViewController(state: Levels.middle(Levels.NameType(
                                                    numberOfBomb: 5,
                                                    numberOfCells: 5)))
    }
    
    @objc private func beginnerButtonTapped() {
        createViewController(state: Levels.beginner(Levels.NameType(
                                                        numberOfBomb: 1,
                                                        numberOfCells: 3)))
    }
    
    private func createViewController(state: Levels) {
        let vc = GameViewController()
        vc.state = state
        navigationController?.pushViewController(vc, animated: false)
    }
    
    private func configureView() {
        title = "SapperGame"
        view.backgroundColor = .white
        
        view.addSubview(vStackView)
        vStackView.addArrangedSubview(advancedButton)
        vStackView.addArrangedSubview(middleButton)
        vStackView.addArrangedSubview(beginnerButton)
    }
    
    private func configureLayoutConstraints() {
        NSLayoutConstraint.activate([
            
            vStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            vStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            vStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            advancedButton.widthAnchor.constraint(equalTo: vStackView.widthAnchor),
            advancedButton.heightAnchor.constraint(equalToConstant: 60),
            
            middleButton.widthAnchor.constraint(equalTo: vStackView.widthAnchor),
            middleButton.heightAnchor.constraint(equalToConstant: 60),
            
            beginnerButton.widthAnchor.constraint(equalTo: vStackView.widthAnchor),
            beginnerButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}
