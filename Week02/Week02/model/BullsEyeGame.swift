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
 * Properties: current value, target value, round number, total score, minimum slider value, maximum slider value
 * Calculated Properties: difference between current and target value
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
 * In this homework, I chose class instead of struct for the model
 * named BullsEyeGame. Because in BullsEyeGame I have multiple
 * mutable properties that will be changed multiple times
 * throughout the game. If I use struct here then I have to use
 * the mutating keyword before every method where the properties
 * will be changed. This will be verbose to read.
 *
 * Also, if I choose struct here, to change the property I have to
 * use var instead of let for the BullsEyeGame object as I have to
 * call mutating methods to change properties. var will allow me to
 * change the object itself. This might lead to a bug in the future.
 * Here I want the reference to be fixed after fist initialization and
 * I just want to change the properties of the object. In this scenario,
 * I think the class is a better choice.
 * 
 *
 **/


class BullsEyeGame {
    
    var currentValue: Int = 0
    
    /*
     * Here, I have encapsulated the mutable variables from the outer world.
     * And only exposed the immutable variables. So that, any dev using this
     * API won't be able to mutate the property accidentally. 
     */
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
