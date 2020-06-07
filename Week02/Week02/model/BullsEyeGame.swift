//
//  BullsEyeGame.swift
//  Week02
//
//  Created by Zoha on 6/7/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import Foundation


/*
 * Ideation for the BullsEyeGame Model
 *
 * Properties: guess value, actual value, round number, total score, minimum slider value, maximum slider value
 * Calculated Properties: difference between gues and actual value
 *
 * Actions: Calcualting point based on difference,
 *          Calculating bonus based on difference,
 *          reset game,
 *          pick random next value
 *
 */

/*
 * Reson Behind Making BullsEyeGame a Class
 *
 * In BullsEyeGame I have multiple mutable properties which will be changed multiple times througt the game
 *
 **/


class BullsEyeGame {
    
    var currentValue: Int = 0
    
    private var _targetValue: Int = 0
    var targetValue: Int {_targetValue}
    
    private var _round: Int = 0
    var round: Int {_round}
    
    private var _totalScore: Int = 0
    var totalScore: Int {_totalScore}
    
    private let minTargetValue: Int
    private let maxTargetValue: Int
    
    var difference: Int {abs(targetValue - currentValue)}
    
    init(minTargetValue: Int, maxTargetValue: Int) {
        self.minTargetValue = minTargetValue
        self.maxTargetValue = maxTargetValue
        
        reset()
    }
    
    func reset() {
        _round = 0
        _totalScore = 0
        nextRound()
    }
    
    func nextRound() {
        _round += 1
        _targetValue = Int.random(in: 1...100)
        currentValue = (minTargetValue+maxTargetValue)/2
    }
    
    func calculateScore() -> Int{
        
        var points = maxTargetValue - difference
        
        if difference == 0 {
            points += 100
        } else if difference == 1 {
            points += 50
        }
        
        _totalScore += points
        
        return points
    }
    
    
    
}
