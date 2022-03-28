//
//  ViewController.swift
//  SapperGame
//
//  Created by pavel mishanin on 28.03.2022.
//

import UIKit

final class ViewController: UIViewController {

    private enum Constants {
        static let cellIdentifier = "cellIdentifier"
    }
    
    private let layout = UICollectionViewFlowLayout()
    private var collectionView: UICollectionView!
    private let size = 6
    private let size2 = 3
    private var arr = [Int]()
    
    var bool: [Bool] = []
    var colors: [UIColor] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createArr()
        createUniqueArray()
        configureView()
    }
    
    private func createUniqueArray() {
        for _ in 0...size {
            bool.append(false)
            colors.append(.gray)
        }
        
        for i in 0..<arr.count {
            bool[arr[i]] = true
        }
    }
    
    private func createArr() {
        var arrays = Array<[Int]>(repeating: [], count: size2)
        var array = [Int]()
        
        for j in 0..<size2 {
            
            let uniqueSize = createUniqueSizeArray(arrays: arrays)
            array.append(uniqueSize)
            arrays[j] = Array<Int>(repeating: 0, count: uniqueSize)
        }
        
        arr = array
    }
    
    private func createUniqueSizeArray(arrays: Array<[Int]>) -> Int {
        var uniqueSize = Int.random(in: 0...size)
        var i = 0
        
        while i < arrays.count - 1 {
            if uniqueSize == arrays[i].count {
                uniqueSize = Int.random(in: 0...size)
                i = 0
            } else {
                i += 1
            }
        }
        
        return uniqueSize
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (collectionView.frame.width - 12)/6, height: (collectionView.frame.width - 12)/6)
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if bool[indexPath.row] {
            print("true")
            colors[indexPath.row] = .red
            collectionView.reloadData()
        } else {
            print("false")
            colors[indexPath.row] = .green
            collectionView.reloadData()
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as! ColorPickerCell
        
        let color = colors[indexPath.item]
        cell.configure(color: color)
        
        return cell
    }
}

private extension ViewController {
    
    func configureView() {
        title = "SapperGame"
        view.backgroundColor = .white
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        
        layout.itemSize = CGSize(width: (collectionView.frame.width - 12)/6, height: (collectionView.frame.width - 12)/6)
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        
        collectionView.register(ColorPickerCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
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
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
