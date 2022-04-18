//
//  GameConfigureLevel.swift
//  SapperGame
//
//  Created by pavel mishanin on 06.04.2022.
//

import UIKit

struct GameType {
    let boolArray: [Bool]
    var colorArray: [UIColor]
    let arr: [Int]
    let numberOfELementsInArray: Int
    let numberOfBomb: Int
    let numberOfCells: CGFloat
    var totalToWinSet: Set<Int>
    var numberOfLives: Int
}

enum GameResult {
    case reload
    case gameWin
    case gameOver
    case onBombTapped
}

protocol GameConfigureLevel {
    func convert(state: LevelsState)
    func getColor(index: Int) -> UIColor
    func numberOfBomb() -> Int
    func getConstant() -> CGFloat
    func numberOfItemsInSection() -> Int
    func didSelectItemAt(index: Int, complition: @escaping(GameResult) -> ())
    func getNumberOfLives() -> Int
}

final class GameConfigureLevelImpl: GameConfigureLevel {
    
    private var gameType: GameType = GameType(boolArray: [], colorArray: [], arr: [], numberOfELementsInArray: 1, numberOfBomb: 1, numberOfCells: 1, totalToWinSet: [], numberOfLives: 0)
    
    init() {
    }
    
    func convert(state: LevelsState) {
        switch state {
        case .beginner:
            config(state: SomeType(numberOfBomb: 1, numberOfCells: 3, numberOfLives: 1))
        case .middle:
            config(state: SomeType(numberOfBomb: 5, numberOfCells: 5, numberOfLives: 2))
        case .advanced:
            config(state: SomeType(numberOfBomb: 10, numberOfCells: 10, numberOfLives: 3))
        }
    }
    
    private func config(state: SomeType) {
        
        let colorArray = Array<UIColor>(repeating: .gray, count: state.numberOfELementsInArray)
        let arr = createRandomBombs(someType: state)
        let boolArray = createArrays(someType: state, arr: arr)
        
        gameType = GameType(boolArray: boolArray,
                 colorArray: colorArray,
                 arr: arr,
                 numberOfELementsInArray: state.numberOfELementsInArray,
                 numberOfBomb: state.numberOfBomb,
                 numberOfCells: state.numberOfCells,
                 totalToWinSet: [],
                 numberOfLives: state.numberOfLives
        )
    }
    
    func getNumberOfLives() -> Int {
        return gameType.numberOfLives
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
        gameType.numberOfLives -= 1
        if gameType.numberOfLives == 0 {
            gameType.totalToWinSet.insert(index)
            return .gameOver
        } else {
            return .onBombTapped
        }
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
