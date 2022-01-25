//
//  ViewController.swift
//  Lab1_PhaniPotu_C0789186_IOS
//
//  Created by Mac on 18/01/22.
//  Copyright © 2022 sreekar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var OScore: UILabel!
    
    @IBOutlet weak var XScore: UILabel!
    
    
    @IBOutlet var Bbutton: [UIButton]!
    
    
    
    var gamearea = [String]()
    var currplayer = ""
    var Xs = 0
    var Os = 0
    var index = 0;
    var b = 0
    
    let gamerules = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with: UIEvent?){
        
        print("Shake")
        print(b)
        
        let btn:UIButton = (view.viewWithTag(b) as? UIButton)!
        
        if btn.isKind(of: UIButton.self) == true{
            let buttontemp = btn as UIButton
            if buttontemp.titleLabel?.text == "X"{
                buttontemp.setTitle(nil, for: .normal)
                currplayer = "X"
                gamearea[index] = ""
                
            }
            else if buttontemp.titleLabel?.text == "O"{
                buttontemp.setTitle(nil, for: .normal)
                currplayer = "O"
                gamearea[index] = ""
            }
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gamePlay()
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipedUp))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
        // Do any additional setup after loading the view.
    }

    @objc func swipedUp(){
        reset()
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        print(sender)
        print(sender.tag)
        b = sender.tag
        index = buttons.index(of: sender)!
        print(index)
        if !gamearea[index].isEmpty{
            print("return")
            return
        }
        if  currplayer == "X"{
            sender.setTitle("X", for: .normal)
            currplayer = "O"
            gamearea[index] = "X"
        }else{
            sender.setTitle("O", for: .normal)
            currplayer = "X"
            gamearea[index] = "O"


        }
        checkGame()
    }
    
    
    
    func checkGame(){
        for j in gamerules{
            let player0 = gamearea[j[0]]
            let player1 = gamearea[j[1]]
            let player2 = gamearea[j[2]]
            if player0 == player1, player1 == player2,!player0.isEmpty{
                print("Winner is \(player1)")
                if player1 == "X"{
                    Xs+=1
                    XScore.text = "Score X - \(Xs)"
                }else {
                    Os+=1
                    OScore.text = "Score O - \(Os)"

                }
                displayalert(msg: "Congrats! \(player2)You Won")
                return
            }

        }
        if !gamearea.contains(""){
             displayalert(msg: "It's Tie")
        }
    }
    func displayalert(msg: String){
        let alert = UIAlertController(title: "Sucess", message: msg , preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default){ _ in
            self.reset()
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
    }
    
    func reset(){
        gamearea.removeAll()
        gamePlay()
        
        for button in buttons{
            button.setTitle(nil, for: .normal)
        }
    }
    
    func gamePlay(){
        for _ in 0..<buttons.count{
            gamearea.append("")
        }
    }
    
}



