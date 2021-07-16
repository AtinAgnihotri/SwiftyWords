//
//  ViewController.swift
//  SwiftyWords
//
//  Created by Atin Agnihotri on 15/07/21.
//

import UIKit

class ViewController: UIViewController {
    var cluesLabel: UILabel!
    var answersLabel: UILabel!
    var scoreLabel: UILabel!
    var currentAnswerTF: UITextField!
    var letterButtons = [UIButton]()
    var buttonsContainterView: UIView!
    var submitButton: UIButton!
    var clearButton: UIButton!

    var score = 0

    override func loadView() {
        createSuperView()
        addScoreLabel()
        addCluesLabel()
        addAnswersLabel()
        addCurrentAnswerTF()
        addLetterButtons()
        addInputButtons()
        addConstraints()
        
        // For dev convenience sake
        // cluesLabel.backgroundColor = .red
        // answersLabel.backgroundColor = .blue
        // buttonsContainterView.backgroundColor = .green
    }
    
    func createSuperView() {
        view = UIView()
        view.backgroundColor = .white
    }
    
    func addConstraints() {
        var allConstraints = [NSLayoutConstraint]()
        allConstraints += getScoreLabelConstraints()
        allConstraints += getCluesLabelConstraints()
        allConstraints += getAnswerLabelConstraints()
        allConstraints += getCurrentAnswerTFConstraints()
        allConstraints += getInputButtonConstraints()
        allConstraints += getButtonContainerViewConstraints()
        NSLayoutConstraint.activate(allConstraints)
//        print(allConstraints)
    }
    
    func addScoreLabel() {
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: \(score)"
        scoreLabel.font = UIFont.systemFont(ofSize: 22)
        view.addSubview(scoreLabel)
    }
    
    func getScoreLabelConstraints() -> [NSLayoutConstraint] {
        [
            // scoreLabel Constraints
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ]
    }
    
    func addCluesLabel() {
        cluesLabel = UILabel()
        cluesLabel.translatesAutoresizingMaskIntoConstraints = false
        cluesLabel.text = "Clues goes here"
        cluesLabel.numberOfLines = 0
        cluesLabel.font = UIFont.systemFont(ofSize: 26)
        cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(cluesLabel)
    }
    
    func getCluesLabelConstraints() -> [NSLayoutConstraint] {
        [
            // cluesLabel Constraints
            cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),
            cluesLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100)
        ]
    }
    
    func addAnswersLabel() {
        answersLabel = UILabel()
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        answersLabel.text = "Answers goes here"
        answersLabel.numberOfLines = 0
        answersLabel.textAlignment = .right
        answersLabel.font = UIFont.systemFont(ofSize: 26)
        answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(answersLabel)
    }
    
    func getAnswerLabelConstraints() -> [NSLayoutConstraint] {
        [
            // answerLabel Constraints
            answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),
            answersLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100),
            answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),
        ]
    }
    
    func addCurrentAnswerTF() {
        currentAnswerTF = UITextField()
        currentAnswerTF.translatesAutoresizingMaskIntoConstraints = false
//        currentAnswerTF.attributedPlaceholder = NSAttributedString.init(string: "Tap letters to submit", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 56)])
        currentAnswerTF.placeholder = "Tap letters to submit"
        currentAnswerTF.textAlignment = .center
//        currentAnswerTF.setValue(UIFont.systemFont(ofSize: 15),forKeyPath: "_placeholderLabel.font")
//        currentAnswerTF.placeholderL
        currentAnswerTF.font = UIFont.systemFont(ofSize: 56)
        currentAnswerTF.isUserInteractionEnabled = false
        view.addSubview(currentAnswerTF)
    }
    
    func getCurrentAnswerTFConstraints() -> [NSLayoutConstraint] {
        [
            currentAnswerTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentAnswerTF.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.5),
            currentAnswerTF.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20)
        ]
    }
    
    func addInputButtons() {
        submitButton = UIButton(type: .system)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.setTitle("SUBMIT", for: .normal)
        submitButton.titleLabel?.font = UIFont.systemFont(ofSize: 34)
        view.addSubview(submitButton)
        
        clearButton = UIButton(type: .system)
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.setTitle("CLEAR", for: .normal)
        clearButton.titleLabel?.font = UIFont.systemFont(ofSize: 34)
        view.addSubview(clearButton)
//        print("Added Submit and Clear Button")
    }
    
    func getInputButtonConstraints() -> [NSLayoutConstraint]{
        [
            // submitButton Constraints
            submitButton.topAnchor.constraint(equalTo: currentAnswerTF.bottomAnchor, constant: 20),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            submitButton.heightAnchor.constraint(equalToConstant: 64),
            // clearButton Constraints
            clearButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            clearButton.centerYAnchor.constraint(equalTo: submitButton.centerYAnchor),
            clearButton.heightAnchor.constraint(equalToConstant: 64)
        ]
    }
    
    func addLetterButtons() {
        // Create container for letter buttons
        buttonsContainterView = UIView()
        buttonsContainterView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsContainterView)
        
        for row in 0..<4 {
            for column in 0..<5 {
                createLetterButton(row: row, column: column)
            }
        }
    }
    
    func createLetterButton(row: Int, column: Int) {
        let width = 150
        let height = 80
        let letterButton = UIButton(type: .system)
        letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
        letterButton.setTitle("WWW", for: .normal)
        let frame = CGRect(x: column * width, y: row * height, width: width, height: height)
        letterButton.frame = frame
        buttonsContainterView.addSubview(letterButton)
        letterButtons.append(letterButton)
    }
    
    func getButtonContainerViewConstraints() -> [NSLayoutConstraint] {
        [
            // buttonContainerView Constraints
            buttonsContainterView.widthAnchor.constraint(equalToConstant: 750),
            buttonsContainterView.heightAnchor.constraint(equalToConstant: 320),
            buttonsContainterView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsContainterView.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 40),
            buttonsContainterView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

