//
//  ViewController.swift
//  SapperGame
//
//  Created by pavel mishanin on 28.03.2022.
//

import UIKit

final class GameViewController: UIViewController {
    
    private enum Constants {
        static let cellIdentifier = "cellIdentifier"
        static let lineSpacing: CGFloat = 1
    }
    
    private let layout = UICollectionViewFlowLayout()
    private var collectionView: UICollectionView!
    private var numberOfBomb = Int()
    private var numberOfELementsInArray = Int()
    private var numberOfCells = CGFloat()
    private var arr = [Int]()
    private let alert = CustomAlert()
    
    private var boolArray: [Bool] = []
    private var colorArray: [UIColor] = []
    private var totalToWinSet: Set<Int> = []
    
    var state: Levels! {
        didSet{
            configureState()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createRandomBombs()
        createArrays()
        configureView()
    }
    
    private func configureState() {
        switch state {
        case .beginner(let beginner):
            congifure(type: beginner)
        case .middle(let middle):
            congifure(type: middle)
        case .advanced(let advanced):
            congifure(type: advanced)
        case .none:
            break
        }
    }
    
    private func congifure(type: Levels.NameType) {
        numberOfCells = type.numberOfCells
        numberOfELementsInArray = Int(numberOfCells*numberOfCells)
        numberOfBomb = type.numberOfBomb
    }
    
    private func createArrays() {
        boolArray = Array<Bool>(repeating: false, count: numberOfELementsInArray)
        colorArray = Array<UIColor>(repeating: .gray, count: numberOfELementsInArray)
        
        for i in 0..<arr.count {
            boolArray[arr[i]] = true
        }
    }
    
    private func createRandomBombs() {
        var randomSet: Set<Int> = []
        while randomSet.count < numberOfBomb {
            let uniqueSize = Int.random(in: 0..<numberOfELementsInArray)
            randomSet.insert(uniqueSize)
        }
        arr = Array(randomSet)
        print(randomSet)
    }
    
    private func notBombTapped(index: Int) {
        totalToWinSet.insert(index)
        colorArray[index] = .green
        collectionView.reloadData()
        
        if totalToWinSet.count == numberOfELementsInArray - numberOfBomb {
            alert.showAlert(view: self, title: "You are win", complition: {
                self.navigationController?.popToRootViewController(animated: false)
            })
        }
    }
    
    private func bombTapped(index: Int) {
        colorArray[index] = .red
        collectionView.reloadData()
        
        alert.showAlert(view: self, title: "Game Over", complition: {
            self.navigationController?.popToRootViewController(animated: false)
        })
    }
}

extension GameViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width/numberOfCells - Constants.lineSpacing
        return CGSize.init(width: width, height: width)
    }
}

extension GameViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if boolArray[indexPath.row] {
            bombTapped(index: indexPath.row)
        } else {
            notBombTapped(index: indexPath.row)
        }
    }
}

extension GameViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as! GameCell
        
        let color = colorArray[indexPath.item]
        cell.configure(color: color)
        
        return cell
    }
}

private extension GameViewController {
    
    func configureView() {
        title = "SapperGame"
        view.backgroundColor = .white
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        
        layout.minimumLineSpacing = Constants.lineSpacing
        layout.minimumInteritemSpacing = Constants.lineSpacing
        
        collectionView.register(GameCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
        view.addSubview(collectionView)
        collectionView.backgroundColor = UIColor.clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        configureLayout()
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor),
            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
