//
//  EntryViewController.swift
//  SapperGame
//
//  Created by pavel mishanin on 01.04.2022.
//

import UIKit

final class EntryViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .fullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "EntryViewController"
        
    }
}
