//
//  QuestionViewController.swift
//  Personality Quiz
//
//  Created by Aleksey Popov on 01/09/2019.
//  Copyright © 2019 Aleksey Popov. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet var singleButtons: [UIButton]!
    @IBOutlet weak var multiplyStackView: UIStackView!
    @IBOutlet var multiLabrls: [UILabel]!
    
    @IBOutlet var multySwitches: [UISwitch]!
    
    @IBOutlet weak var rangeStackView: UIStackView!
    
    @IBOutlet weak var rangedSlider: UISlider!
    
    @IBOutlet var rangedLabels: [UILabel]!
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBAction func singleButtonPressed(_ sender: UIButton) {
        let answers = questions[questionIndex].answer
        
        for index in 0 ..< singleButtons.count {
            if singleButtons[index] == sender {
                answersChosen.append(answers[index])
                break
            }
        }
        nexQuestion()
    }
    
    
    
    
    @IBAction func multyButtonPressed() {
        
        let answers = questions[questionIndex].answer
        
        for index in 0..<multySwitches.count {
            if multySwitches[index].isOn {
                answersChosen.append(answers[index])
            }
        }
        nexQuestion()
    }
    
    @IBAction func rangedButtonPressed() {
        
        let answers = questions[questionIndex].answer
        
        let index = Int (round (rangedSlider.value * Float(answers.count - 1)))
        answersChosen.append(answers[index])
        
        nexQuestion()
    }
    
    var questions: [Question] = [
        Question(text: "Что ты больше всего любишь есть?",
                 type: .single,
                 answer: [
                    Answer (text: "Мясо", type: .dog),
                    Answer (text: "Рыба", type: .cat),
                    Answer (text: "Морковь", type: .rabbit),
                    Answer (text: "Кукуруза", type: .turtle)
            ]
        ),
        Question(text: "Что вы любите делать?",
                 type: .multiple,
                 answer: [
                    Answer (text: "Спать", type: .cat),
                    Answer (text: "Плавать", type: .turtle),
                    Answer (text: "Играть", type: .dog),
                    Answer (text: "Прыгать", type: .rabbit),
            ]
        ),
        Question(text: "Любите ли вы езду на машине",
                 type: .ranged,
                 answer: [
                    Answer (text: "Ненавижу", type: .cat),
                    Answer (text: "Меня она нервирует", type: .rabbit),
                    Answer (text: "Я ее не замечаю", type: .turtle),
                    Answer (text: "Обожаю", type: .dog),
            ]
        ),
    ]
    
    var questionIndex = 0
    var answersChosen: [Answer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
    }
    func updateUI (){
        singleStackView.isHidden = true
        multiplyStackView.isHidden = true
        rangeStackView.isHidden = true
        
        
        let question = questions [questionIndex]
        let answers = question.answer
        let progress = Float (questionIndex) / Float (questions.count)
        
        navigationItem.title = "Вопрос № \(questionIndex + 1)"
        questionLabel.text = question.text
        progressView.setProgress(progress, animated: true)
        
        
        
        switch question.type {
        case .single:
            updateSingleStack (using: answers)
        case .multiple:
            updateMultiplyStack (using: answers)
        case . ranged:
            updateRangedStack (using: answers)
        }
    }
    
    func updateSingleStack (using answers: [Answer]) {
        singleStackView.isHidden = false
        for index in 0 ..< answers.count {
            singleButtons[index].setTitle(answers[index].text, for: .normal)
        }
    }
    func updateMultiplyStack (using answers: [Answer]) {
        multiplyStackView.isHidden = false
        for index in 0 ..< answers.count {
            multiLabrls[index].text = answers[index].text
            multySwitches[index].isOn = false
        }
    }
    func updateRangedStack (using answers: [Answer]) {
        rangeStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: false)
        rangedLabels[0].text = answers.first?.text
        rangedLabels[1].text = answers.last?.text
    }
    
    func nexQuestion () {
        questionIndex += 1
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "ResultsSeque", sender: nil)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSeque" {
          let resultsViewController = segue.destination as! ResultsViewController
        resultsViewController.responces = answersChosen
        }
    }
}
