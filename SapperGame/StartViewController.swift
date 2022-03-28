//
//  File.swift
//  SapperGame
//
//  Created by pavel mishanin on 28.03.2022.
//

import UIKit

final class StartViewController: UIViewController {
    
    private let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
    }
    
    private func configureLayout() {
        configureView()
        configureLayoutConstraints()
        configureButton()
    }
    
    private func configureButton() {
        button.layer.cornerRadius = 30
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.red.cgColor
        button.setTitle("Start", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font =  UIFont(name: "Helvetica", size: 25)
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        print("tap")
        let vc = ViewController()
        navigationController?.pushViewController(vc, animated: false)
    }
    
    private func configureView() {
        view.backgroundColor = .white
        
        [button].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        view.addSubview(button)
    }
    
    private func configureLayoutConstraints() {
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            button.heightAnchor.constraint(equalToConstant: 60),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
