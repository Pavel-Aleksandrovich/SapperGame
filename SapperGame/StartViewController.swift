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
        let vc = GameViewController()
        vc.state = Levels.advanced(Levels.NameType(
                                    numberOfBomb: 10,
                                    numberOfCells: 10))
        navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc private func middleButtonTapped() {
        let vc = GameViewController()
        vc.state = Levels.middle(Levels.NameType(
                                            numberOfBomb: 5,
                                            numberOfCells: 5))
        navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc private func beginnerButtonTapped() {
        let vc = GameViewController()
        vc.state = Levels.beginner(Levels.NameType(
                                            numberOfBomb: 1,
                                            numberOfCells: 3))
        navigationController?.pushViewController(vc, animated: false)
    }
    
    private func configureView() {
        title = "SapperGame"
        view.backgroundColor = .white
        
        view.addSubview(advancedButton)
        view.addSubview(beginnerButton)
        view.addSubview(middleButton)
    }
    
    private func configureLayoutConstraints() {
        NSLayoutConstraint.activate([
            advancedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            advancedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            advancedButton.heightAnchor.constraint(equalToConstant: 60),
            advancedButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            middleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            middleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            middleButton.heightAnchor.constraint(equalToConstant: 60),
            middleButton.topAnchor.constraint(equalTo: advancedButton.bottomAnchor, constant: 30),
            
            beginnerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            beginnerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            beginnerButton.heightAnchor.constraint(equalToConstant: 60),
            beginnerButton.topAnchor.constraint(equalTo: middleButton.bottomAnchor, constant: 30),
        ])
    }
}
