//
//  ViewController.swift
//  CalculadoraDigitalHouse
//
//  Created by Marcelo Squarisi on 10/09/20.
//  Copyright © 2020 Marcelo Squarisi. All rights reserved.
//

import UIKit

// Define classe de botão arrendodado
@IBDesignable class BotaoRound: UIButton
{
  
    override func layoutSubviews() {
        super.layoutSubviews()
        UpdateCornerRadius()
    }
    
    
    @IBInspectable var isRound: Bool = true{
        didSet{
            UpdateCornerRadius()
        }
    }
   
    func UpdateCornerRadius() {
        // sedefinido como redondo atualiza a propriedade em razão da altura, se não define como zero
        layer.cornerRadius = isRound ? frame.size.height / 2 : 0
    }
}


class ViewController: UIViewController {

    @IBOutlet var holder: UIView!
    
        
    // Colors definitions
    let btNumericosBackgroudColor: UIColor = .darkGray
    let btNumericsTextColor: UIColor = .white
    let btOperatorsBackgroudColor: UIColor = .orange
    let btOperatorsTextColor: UIColor = .white
    let btMisBackgroudColor: UIColor = .lightGray
    let btMisTextColor: UIColor = .black
    
    
    //Result Label
    //let resultLabelHeight: CGFloat = holder.frame.size.height
    var resultLabel: UILabel = {
       let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .right
        //label.font = UIFont(name: "Arial", size: 30)
        return label
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupKeyPad()
        
    }
   
    
    private func setupKeyPad(){
        let holderHeight: CGFloat = holder.frame.size.height
        let btSize = holder.frame.size.width / 4
        let operacoes = ["=", "+", "-", "x", "/"]
        let misButtuns = ["AC", "+/-", "%"]
        
        // Create and add zero button
        let btZero = BotaoRound(frame: CGRect(x: 0, y: holderHeight - btSize,
                                            width: btSize * 2, height: btSize))
        btZero.backgroundColor = btNumericosBackgroudColor
        btZero.setTitleColor(btNumericsTextColor, for: .normal)
        btZero.setTitle("0" , for: .normal)
        holder.addSubview(btZero)
        btZero.tag = 0
        btZero.addTarget(self, action: #selector(keyPressed), for: .touchUpInside)

        //cria e adiciona o botão de ,
        let btComa = BotaoRound(frame: CGRect(x: btSize * CGFloat(2), y: holderHeight - btSize,
                                            width: btSize, height: btSize))
        btComa.backgroundColor = btNumericosBackgroudColor
        btComa.setTitleColor(btNumericsTextColor, for: .normal)
        btComa.setTitle("," , for: .normal)
        holder.addSubview(btComa)
        
        // cria e addiciona os botoes de  1 a 3
        for x in 0..<3{
             let bt = BotaoRound(frame: CGRect(x: btSize * CGFloat(x) , y: holderHeight - (btSize*2),
                                                       width: btSize, height: btSize))
            bt.backgroundColor = btNumericosBackgroudColor
            bt.setTitleColor(btNumericsTextColor, for: .normal)
            bt.setTitle("\(x+1)" , for: .normal)
            holder.addSubview(bt)
            bt.tag = x + 1
            
        }
        
        
        // cria e add os botões de 4 a 6
               for x in 0..<3{
                    let bt = BotaoRound(frame: CGRect(x: btSize * CGFloat(x) , y: holderHeight - (btSize*3),
                                                              width: btSize, height: btSize))
                bt.backgroundColor = btNumericosBackgroudColor
                bt.setTitleColor(btNumericsTextColor, for: .normal)
                bt.setTitle("\(x+3)" , for: .normal)
                holder.addSubview(bt)
                bt.tag = x + 3
               }
        
        // cria e add os botões de 7 a 9
        for x in 0..<3{
             let bt = BotaoRound(frame: CGRect(x: btSize * CGFloat(x) , y: holderHeight - (btSize*4),
                                                       width: btSize, height: btSize))
            bt.backgroundColor = btNumericosBackgroudColor
            bt.setTitleColor(btNumericsTextColor, for: .normal)
            bt.setTitle("\(x+7)" , for: .normal)
            holder.addSubview(bt)
            bt.tag = x + 7
        }
        
        // cria e adciona os botoes de operacoes
        for x in 0..<5{
            let bt = BotaoRound(frame: CGRect(x: btSize * 3 , y: holderHeight - (btSize * CGFloat(x + 1)),
                                                                 width: btSize, height: btSize))
                             bt.backgroundColor = btOperatorsBackgroudColor
                             bt.setTitleColor(btOperatorsTextColor, for: .normal)
                             bt.setTitle("\(operacoes[x])" , for: .normal)
                             holder.addSubview(bt)
        }
        
        // cria e adiciona os botoes AC, troca sinal, percentual
        for x in 0..<3{
            let bt = BotaoRound(frame: CGRect(x: btSize * CGFloat(x) , y: holderHeight - (btSize*5),
                                                                  width: btSize, height: btSize))
                              bt.backgroundColor = btMisBackgroudColor
                              bt.setTitleColor(btMisTextColor, for: .normal)
                              bt.setTitle("\(misButtuns[x])" , for: .normal)
                              holder.addSubview(bt)
        }
        resultLabel.font = UIFont(name: "Arial", size: holder.frame.size.height * 0.15 ) // define o tamanho de fonte como 15% da tela
        // Define a posição da label como 6 linha e a altura como 20% da tela
        resultLabel.frame = CGRect(x: 0, y: btZero.frame.origin.y - (btSize*6),
                                   width: view.frame.size.width, height: holder.frame.size.height * 0.20)
        holder.addSubview(resultLabel)
        
        //Action
        
        
        
    }// Fim setup keyPad
    
    @objc func keyPressed(_ sender: UIButton){
        let tag = sender.tag
        switch tag {
        case 0...9:
            resultLabel.text = String(tag)
        default:
            break
        }
        
    }
    
}

