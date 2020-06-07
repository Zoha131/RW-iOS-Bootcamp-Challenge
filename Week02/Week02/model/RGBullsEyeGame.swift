//
//  RGBullsEyeGame.swift
//  Week02
//
//  Created by Zoha on 6/7/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import Foundation

class RGBullsEyeGame {
    
    var currentValue: RGB = RGB()
    
    private var _targetValue: RGB = RGB()
    var targetValue: RGB {_targetValue}
    
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
        _targetValue = RGB.random()
        currentValue = RGB()
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
