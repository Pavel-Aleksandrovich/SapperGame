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
    private var alert = CustomAlert()
    
    private var bool: [Bool] = []
    private var colors: [UIColor] = []
    private var numb: Set<Int> = []
    
    var state: Levels! {
        didSet{
            configureState()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createArr()
        createUniqueArray()
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
    
    private func createUniqueArray() {
        for _ in 0..<numberOfELementsInArray {
            bool.append(false)
            colors.append(.gray)
        }
        
        for i in 0..<arr.count {
            bool[arr[i]] = true
        }
    }
    
    private func createArr() {
        var arrays = Array<[Int]>(repeating: [], count: numberOfBomb)
        var array = [Int]()
        
        for j in 0..<numberOfBomb {
            
            let uniqueSize = createUniqueSizeArray(arrays: arrays)
            array.append(uniqueSize)
            arrays[j] = Array<Int>(repeating: 0, count: uniqueSize)
        }
        
        arr = array
        print(arr)
    }
    
    private func createUniqueSizeArray(arrays: Array<[Int]>) -> Int {
        var uniqueSize = Int.random(in: 0..<numberOfELementsInArray)
        var i = 0
        
        while i < arrays.count - 1 {
            if uniqueSize == arrays[i].count {
                uniqueSize = Int.random(in: 0..<numberOfELementsInArray)
                i = 0
            } else {
                i += 1
            }
        }
        return uniqueSize
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
        if bool[indexPath.row] {
            colors[indexPath.row] = .red
            collectionView.reloadData()
            alert.showAlert(view: self, title: "Game Over", complition: {
                self.navigationController?.popToRootViewController(animated: false)
            })
        } else {
            numb.insert(indexPath.row)
            colors[indexPath.row] = .green
            collectionView.reloadData()
            if numb.count == numberOfELementsInArray - numberOfBomb {
                alert.showAlert(view: self, title: "You are win", complition: {
                    self.navigationController?.popToRootViewController(animated: false)
                })
            } else {
                return
            }
        }
    }
}

extension GameViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as! GameCell
        
        let color = colors[indexPath.item]
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
        collectionView.center = view.center
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
