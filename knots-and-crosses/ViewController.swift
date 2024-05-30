//
//  ViewController.swift
//  knots-and-crosses
//
//  Created by Ueta, Lucas T on 10/11/23.
//

import UIKit

class ViewController: UIViewController {
    
    var buttons: [UIButton] = [], columns: [UIStackView] = [], turn: Fill = .x, game = Game(), label = UILabel(), grid = UIStackView(), stack = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        view.backgroundColor = .black
        
        stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 150
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        label.textColor = .white
        label.font = UIFont(name: "Arial", size: 24)
        label.text = "X's turn"
        stack.addArrangedSubview(label)
        
        grid = UIStackView()
        grid.translatesAutoresizingMaskIntoConstraints = false
        grid.axis = .horizontal
        grid.alignment = .center
        grid.distribution = .equalCentering
        stack.addArrangedSubview(grid)
        NSLayoutConstraint.activate([
            grid.widthAnchor.constraint(equalToConstant: 300),
            grid.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        for i in 0...2 {
            let column = UIStackView()
            column.translatesAutoresizingMaskIntoConstraints = false
            column.axis = .vertical
            column.alignment = .center
            column.distribution = .fillEqually
            
            columns.append(column)
            grid.addArrangedSubview(column)
            
            for j in 0...2 {
                let button = UIButton()
                button.setTitle(" ", for: .normal)
                button.setTitleColor(.white, for: .normal)
                button.titleLabel?.font = UIFont(name: "Arial", size: 48)
                button.tag = i * 3 + j
                
                buttons.append(button)
                column.addArrangedSubview(button)
                button.addTarget(self, action: #selector(self.pick(_:)), for: .touchUpInside)
                
                if j < 2 { column.addArrangedSubview(getLabel("—")) }
            }
            if i < 2 {
                let pipes = UIStackView()
                pipes.axis = .vertical
                pipes.alignment = .center
                pipes.distribution = .fillEqually
                
                for _ in 0...2 { pipes.addArrangedSubview(getLabel("|")) }
                grid.addArrangedSubview(pipes)
            }
        }
    }
    
    func getLabel(_ character: String) -> UILabel {
        let pipe = UILabel()
        pipe.textColor = .white
        pipe.font = UIFont(name: "Arial", size: 96)
        pipe.text = character
        return pipe
    }

    @objc func pick(_ sender: UIButton) {
        if sender.titleLabel!.text != " " { return }
        
        game.play(turn, at: sender.tag)
        sender.setTitle(turn == .x ? "X" : "O", for: .normal)
        
        if game.winner != .empty {
            label.text = "\(game.winner == .x ? "X" : "O") WINS!"
            Timer.scheduledTimer(timeInterval: 3.5, target: self, selector: #selector(reset), userInfo: nil, repeats: false)
            return
        }
        
        turn = turn == .x ? .o : .x
        label.text = "\(turn)'s turn"
    }
    
    @objc func reset() {
        game = Game()
        stack.removeFromSuperview()
        viewDidLoad()
    }
}

