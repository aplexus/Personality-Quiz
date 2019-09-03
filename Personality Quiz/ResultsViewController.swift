//
//  ResultsViewController.swift
//  Personality Quiz
//
//  Created by Aleksey Popov on 01/09/2019.
//  Copyright © 2019 Aleksey Popov. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    @IBOutlet weak var resultAnswerLabel: UILabel!
    @IBOutlet weak var resultDefinitionLabel: UILabel!
    
    var responces: [Answer]!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        calculateResult()
    }
    
    
    func calculateResult () {
        var frequenceOfAnswers: [AnimalType: Int] = [:]
        
        let responceTypes = responces.map {$0.type}
        
        for responce in responceTypes {
            frequenceOfAnswers[responce] = (frequenceOfAnswers [responce] ?? 0) + 1
        }
        
        let frequencyOfAnswersSorted = frequenceOfAnswers.sorted(by: {(pair1, pair2) -> Bool in return pair1.value > pair2.value})
        
   let mosCommonAnswers = frequencyOfAnswersSorted.first!.key
        
        resultAnswerLabel.text = "Вы - это \(mosCommonAnswers.rawValue)!"
        resultDefinitionLabel.text = mosCommonAnswers.definition
    }
    
}
