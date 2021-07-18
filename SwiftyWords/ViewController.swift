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

    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var level = 1
    
    var solutions = [String]()
    var activatedButtons = [UIButton]()

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
        currentAnswerTF.placeholder = "Tap letters to submit"
        currentAnswerTF.textAlignment = .center
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
        submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        view.addSubview(submitButton)
        
        clearButton = UIButton(type: .system)
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.setTitle("CLEAR", for: .normal)
        clearButton.titleLabel?.font = UIFont.systemFont(ofSize: 34)
        clearButton.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        view.addSubview(clearButton)
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
        letterButton.layer.borderWidth = 1
        letterButton.layer.borderColor = UIColor.lightGray.cgColor
        letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
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
    
    
    
    func loadLevel() {
        let levelName = "level\(level)"
        var clueString = ""
        var solutionsString = ""
        var letters = [String]()
        
        if let url = Bundle.main.url(forResource: levelName, withExtension: "txt") {
            if let levelData = try? String(contentsOf: url) {
                print(levelData)
                var lines = levelData.components(separatedBy: "\n")
                lines.shuffle()
                for (index, line) in lines.enumerated() {
                    let parts = line.components(separatedBy: ":")
                    let answer = parts[0]
                    let clue = parts[1]
                    
                    clueString += "\(index + 1).\(clue)\n"
                    let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                    solutionsString += "\(solutionWord.count) letters\n"
                    solutions.append(solutionWord)
                    
                    letters += answer.components(separatedBy: "|")
                    
                }
            } else {
                fatalError("⚠️ Could not load data from level file")
            }
        } else {
            fatalError("⚠️ Could not load level file")
        }
        
        cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
        answersLabel.text = solutionsString.trimmingCharacters(in: .whitespacesAndNewlines)
        addLoadedLetters(letters)
    }
    
    
    func addLoadedLetters(_ letters: [String]) {
        guard letters.count == letterButtons.count else {
            fatalError("⚠️ Insufficient letters loaded from level file")
        }
        let letters = letters.shuffled()
        for (index, letter) in letters.enumerated() {
            letterButtons[index].setTitle(letter, for: .normal)
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadLevel()
        print("tsla: \(isActualWord("tsla"))")
    }
    
    @objc func submitTapped(_ sender: UIButton) {
        if let answer = currentAnswerTF.text {
            if let solutionPosition = solutions.firstIndex(of: answer) {
                score += 3
//                scoreLabel.text = "Score: \(score)"
                updateAnswerLabel(for: solutionPosition, with: answer)
                clearCurrentAnswerLabel()
                
                if solvedAllQuestions() {
                    if level < 2 {
                        showLevelUpAlert()
                    } else {
                        let ok = UIAlertAction(title: "OK", style: .default)
                        showAlert(title: "Game Over", message: "Nice Playing", action: ok)
                    }
                }
                return
            }
        }
        score -= 1
        clearWrongAnswer(showAlert: true)
    }
    
    func updateAnswerLabel(for index: Int, with answer: String) {
        var splitAnswers = answersLabel.text?.components(separatedBy: "\n")
        splitAnswers?[index] = answer
        answersLabel.text = splitAnswers?.joined(separator: "\n")
    }
    
    @objc func clearTapped(_ sender: UIButton) {
        clearWrongAnswer()
    }
    
    @objc func letterTapped(_ sender: UIButton) {
        guard let buttonTitle = sender.titleLabel?.text else { return }
        guard activatedButtons.count < 4 else { return }
        currentAnswerTF.text = currentAnswerTF.text?.appending(buttonTitle)
        activatedButtons.append(sender)
        sender.isHidden = true
    }
    
    func isActualWord(_ word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }
    
    func clearWrongAnswer(showAlert: Bool = false) {
        if showAlert {
            var errorMsg: String
            if isActualWord(currentAnswerTF.text?.lowercased() ?? "") {
                errorMsg = "That's incorrect, give it another try"
            } else  {
                errorMsg = "Come on! That's not even a word"
            }
            showErrorAlert(title: "Try Again", message: errorMsg)
        }
        for button in activatedButtons {
            button.isHidden = false
        }
        clearCurrentAnswerLabel()
    }
    
    func clearCurrentAnswerLabel() {
        activatedButtons.removeAll()
        currentAnswerTF.text = ""
    }
    
    func levelUp (_ action: UIAlertAction) {
        level += 1
        solutions.removeAll(keepingCapacity: true)
        loadLevel()
        for button in letterButtons {
            button.isHidden = false
        }
    }
    
    func solvedAllQuestions() -> Bool {
        guard let answerLabelText = answersLabel.text else {
            return false
        }
        for solution in solutions {
            if !answerLabelText.contains(solution) {
                return false
            }
        }
        return true
    }
    
    
    func showAlert(title: String, message: String, action: UIAlertAction) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(action)
        present(ac, animated: true)
    }
    
    func showInfoAlert(title: String, message: String) {
        let ok = UIAlertAction(title: "OK", style: .default)
        showAlert(title: title, message: message, action: ok)
    }
    
    func showLevelUpAlert() {
        let letsGo = UIAlertAction(title: "Let's go", style: .default, handler: levelUp)
        showAlert(title: "Well done!", message: "Ready for the next level?", action: letsGo)
    }
    
    func showErrorAlert(title: String, message: String) {
        showInfoAlert(title: "⚠️ " + title , message: message)
    }

}

