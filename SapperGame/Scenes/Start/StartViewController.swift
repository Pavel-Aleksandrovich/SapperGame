//
//  File.swift
//  SapperGame
//
//  Created by pavel mishanin on 28.03.2022.
//

import UIKit
import Firebase

struct SomeType {
    let numberOfBomb: Int
    let numberOfCells: CGFloat
    var numberOfELementsInArray: Int {
        return Int(numberOfCells) * Int(numberOfCells)
    }
}

final class StartViewController: UIViewController {
    
    private let advancedButton = CustomButton()
    private let beginnerButton = CustomButton()
    private let middleButton = CustomButton()
    private let vStackView = CustomStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureLayoutConstraints()
        configureAdvancedButton()
        createBarButtonItem()
    }
    
    private func configureAdvancedButton() {
        advancedButton.customButton(title: "Advanced", action: #selector(advancedButtonTapped), view: self, color: .red)
        
        middleButton.customButton(title: "Middle", action: #selector(middleButtonTapped), view: self, color: .blue)
        
        beginnerButton.customButton(title: "Beginner", action: #selector(beginnerButtonTapped), view: self, color: .green)
    }
    
    @objc private func advancedButtonTapped() {
        createViewController(state: SomeType(numberOfBomb: 10, numberOfCells: 10))
    }
    
    @objc private func middleButtonTapped() {
        createViewController(state: SomeType(numberOfBomb: 5, numberOfCells: 5))
    }
    
    @objc private func beginnerButtonTapped() {
        createViewController(state: SomeType(numberOfBomb: 1, numberOfCells: 3))
    }
    
    private func createViewController(state: SomeType) {
        let vc = GameViewController()
        vc.someType = state
        navigationController?.pushViewController(vc, animated: false)
    }
    
    private func createBarButtonItem() {
        let exitBarButton = UIBarButtonItem(title: "Exit", style: .done, target: self, action: #selector(exitButtonTapped))
        navigationItem.leftBarButtonItem = exitBarButton
    }
    
    @objc private func exitButtonTapped() {
        do{
            try Auth.auth().signOut()
        }catch {
            print("error")
        }
    }
    
    private func configureView() {
        title = "SapperGame"
        view.backgroundColor = .white
        
        view.addSubview(vStackView)
        vStackView.addArrangedSubviews([advancedButton, middleButton, beginnerButton])
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
