//
//  GameConverter.swift
//  SapperGame
//
//  Created by pavel mishanin on 06.04.2022.
//

import UIKit

struct GameType {
    var boolArray: [Bool]
    var colorArray: [UIColor]
    var arr: [Int]
    var numberOfELementsInArray: Int
    var numberOfBomb: Int
    var numberOfCells: CGFloat
}

final class GameConverter {
    
    func convert(state: SomeType) -> GameType {
        let colorArray = Array<UIColor>(repeating: .gray, count: state.numberOfELementsInArray)
        let arr = createRandomBombs(someType: state)
        let boolArray = createArrays(someType: state, arr: arr)
        
        return GameType(boolArray: boolArray,
                 colorArray: colorArray,
                 arr: arr,
                 numberOfELementsInArray: state.numberOfELementsInArray,
                 numberOfBomb: state.numberOfBomb,
                 numberOfCells: state.numberOfCells
        )
    }
    
    private func createRandomBombs(someType: SomeType) -> [Int] {
        var arr = [Int]()
        var randomSet: Set<Int> = []
        while randomSet.count < someType.numberOfBomb {
            let uniqueSize = Int.random(in: 0..<someType.numberOfELementsInArray)
            randomSet.insert(uniqueSize)
        }
        arr = Array(randomSet)
        print(randomSet)
        return arr
    }
    
    private func createArrays(someType: SomeType, arr: [Int]) -> [Bool] {
       var boolArray = Array<Bool>(repeating: false, count: someType.numberOfELementsInArray)
       
        for i in 0..<arr.count {
            boolArray[arr[i]] = true
        }
        
        return boolArray
    }
    
   
}
