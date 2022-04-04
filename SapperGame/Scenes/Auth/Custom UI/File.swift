//
//  File.swift
//  SapperGame
//
//  Created by pavel mishanin on 01.04.2022.
//

import UIKit

final class Alert: UIView {
    
    private var view: UIViewController?
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let button = UIButton()
//    private let titleLabel = UIButton()
    
    override init(frame: CGRect) {
//        self.view = view
        
        super.init(frame: frame)
//        confgureView()
//        configureLayout()
        backgroundColor = .systemPink
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func confgureView() {
        layer.borderWidth = 3
        layer.borderColor = UIColor.blue.cgColor
        self.backgroundColor = .systemPink
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "text"
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = .red
    }
    
    func configureLayout(view: UIViewController) {
        
        guard let view = view.view else { return }
        
        view.addSubview(self)
        addSubview(titleLabel)
        confgureView()
        
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            self.widthAnchor.constraint(equalTo: widthAnchor),
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}
