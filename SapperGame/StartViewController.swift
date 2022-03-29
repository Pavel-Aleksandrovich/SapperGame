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
    
    private let advancedButton = UIButton()
    private let beginnerButton = UIButton()
    private let middleButton = UIButton()
    
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
        advancedButton.layer.cornerRadius = 30
        advancedButton.layer.borderWidth = 2
        advancedButton.layer.borderColor = UIColor.red.cgColor
        advancedButton.setTitle("Advanced", for: .normal)
        advancedButton.setTitleColor(.red, for: .normal)
        advancedButton.titleLabel?.font =  UIFont(name: "Helvetica", size: 25)
        
        advancedButton.addTarget(self, action: #selector(advancedButtonTapped), for: .touchUpInside)
        
        middleButton.layer.cornerRadius = 30
        middleButton.layer.borderWidth = 2
        middleButton.layer.borderColor = UIColor.blue.cgColor
        middleButton.setTitle("Middle", for: .normal)
        middleButton.setTitleColor(.blue, for: .normal)
        middleButton.titleLabel?.font =  UIFont(name: "Helvetica", size: 25)
        
        middleButton.addTarget(self, action: #selector(middleButtonTapped), for: .touchUpInside)
        
        beginnerButton.layer.cornerRadius = 30
        beginnerButton.layer.borderWidth = 2
        beginnerButton.layer.borderColor = UIColor.green.cgColor
        beginnerButton.setTitle("Beginner", for: .normal)
        beginnerButton.setTitleColor(.green, for: .normal)
        beginnerButton.titleLabel?.font =  UIFont(name: "Helvetica", size: 25)
        
        beginnerButton.addTarget(self, action: #selector(beginnerButtonTapped), for: .touchUpInside)
    }
    
    @objc private func advancedButtonTapped() {
        let vc = ViewController()
        vc.state = Levels.advanced(Levels.NameType(
                                    numberOfBomb: 10,
                                    numberOfCells: 10))
        navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc private func middleButtonTapped() {
        let vc = ViewController()
        vc.state = Levels.middle(Levels.NameType(
                                            numberOfBomb: 5,
                                            numberOfCells: 5))
        navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc private func beginnerButtonTapped() {
        let vc = ViewController()
        vc.state = Levels.beginner(Levels.NameType(
                                            numberOfBomb: 1,
                                            numberOfCells: 3))
        navigationController?.pushViewController(vc, animated: false)
    }
    
    private func configureView() {
        title = "SapperGame"
        view.backgroundColor = .white
        
        [advancedButton, beginnerButton, middleButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
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
