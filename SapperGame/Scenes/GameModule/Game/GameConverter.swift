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
    var totalToWinSet: Set<Int>
}

enum GameResult {
    case reload
    case gameWin
    case gameOver
}

final class GameConverter {
    
    private var gameType: GameType = GameType(boolArray: [], colorArray: [], arr: [], numberOfELementsInArray: 1, numberOfBomb: 1, numberOfCells: 1, totalToWinSet: [])
    
    init(state: SomeType) {
        convert(state: state)
    }
    
    func convert(state: SomeType) {
        let colorArray = Array<UIColor>(repeating: .gray, count: state.numberOfELementsInArray)
        let arr = createRandomBombs(someType: state)
        let boolArray = createArrays(someType: state, arr: arr)
        
        gameType = GameType(boolArray: boolArray,
                 colorArray: colorArray,
                 arr: arr,
                 numberOfELementsInArray: state.numberOfELementsInArray,
                 numberOfBomb: state.numberOfBomb,
                 numberOfCells: state.numberOfCells,
                 totalToWinSet: []
        )
    }
    
    func getColor(index: Int) -> UIColor {
        return gameType.colorArray[index]
    }
    
    func numberOfBomb() -> Int {
        return gameType.numberOfBomb
    }
    
    func getConstant() -> CGFloat {
        return gameType.numberOfCells
    }
    
    func numberOfItemsInSection() -> Int {
        return gameType.colorArray.count
    }
    
    func didSelectItemAt(index: Int, complition: @escaping(GameResult) -> ()) {
        if gameType.boolArray[index] {
            complition(bombTapped(index: index))
        } else {
            complition(notBombTapped(index: index))
        }
    }
    
    private func notBombTapped(index: Int) -> GameResult {
        gameType.totalToWinSet.insert(index)
        gameType.colorArray[index] = .green
        
        if gameType.totalToWinSet.count == gameType.numberOfELementsInArray - gameType.numberOfBomb {
            return .gameWin
        }
        return .reload
    }
    
    private func bombTapped(index: Int) -> GameResult  {
        gameType.colorArray[index] = .red
        return .gameOver
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
