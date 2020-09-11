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
    
    //Variáveis matematicas
    var operando: Double = 0.00
    var operador: Double = 0.00
    var resultado: Double = 0.00
    var curretntOprentions: Operation?
    
    enum Operation{
        case add, sub, times, divide, equal}
    
    
    //Variáveis de controle
    var hasComa: Bool = false // Controla se o número já tem uma vírgula
    var onCalc: Bool = false // Controla se o operador já foi definido
    
    //Result Label
    var lbResult: UILabel = {
       let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .right
        //label.font = UIFont(name: "Arial", size: 30)
        return label
    }()
    
    var lbHistorico: UILabel =
    {
        let label = UILabel()
        label.text = ""
        label.textColor = .gray
        label.backgroundColor = .darkGray
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
        btZero.addTarget(self, action: #selector(numPressed), for: .touchUpInside)

        //cria e adiciona o botão de ,
        
        let btComa = BotaoRound(frame: CGRect(x: btSize * CGFloat(2), y: holderHeight - btSize,
                                            width: btSize, height: btSize))
        btComa.backgroundColor = btNumericosBackgroudColor
        btComa.setTitleColor(btNumericsTextColor, for: .normal)
        btComa.setTitle("," , for: .normal)
        holder.addSubview(btComa)
        btComa.tag = 20
        btComa.addTarget(self, action: #selector(numPressed), for: .touchUpInside)
        
        // cria e addiciona os botoes de  1 a 3
        for x in 0..<3{
             let bt = BotaoRound(frame: CGRect(x: btSize * CGFloat(x) , y: holderHeight - (btSize*2),
                                                       width: btSize, height: btSize))
            bt.backgroundColor = btNumericosBackgroudColor
            bt.setTitleColor(btNumericsTextColor, for: .normal)
            bt.setTitle("\(x+1)" , for: .normal)
            holder.addSubview(bt)
            bt.tag = x + 1
            bt.addTarget(self, action: #selector(numPressed), for: .touchUpInside)
            
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
            bt.addTarget(self, action: #selector(numPressed), for: .touchUpInside)
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
            bt.addTarget(self, action: #selector(numPressed), for: .touchUpInside)
        }
        
        // cria e adciona os botoes de operacoes
        for x in 0..<5{
            let bt = BotaoRound(frame: CGRect(x: btSize * 3 , y: holderHeight - (btSize * CGFloat(x + 1)),
                                                                 width: btSize, height: btSize))
            bt.backgroundColor = btOperatorsBackgroudColor
            bt.setTitleColor(btOperatorsTextColor, for: .normal)
            bt.setTitle("\(operacoes[x])" , for: .normal)
            holder.addSubview(bt)
            bt.tag = x + 1
            bt.addTarget(self, action: #selector(OperatorPresed), for: .touchUpInside)
            
        }
        
        // cria e adiciona os botoes AC, troca sinal, percentual
        for x in 0..<3{
            let bt = BotaoRound(frame: CGRect(x: btSize * CGFloat(x) , y: holderHeight - (btSize*5),
                                                                  width: btSize, height: btSize))
            bt.backgroundColor = btMisBackgroudColor
            bt.setTitleColor(btMisTextColor, for: .normal)
            bt.setTitle("\(misButtuns[x])" , for: .normal)
            holder.addSubview(bt)
            bt.tag = x + 6
            bt.addTarget(self, action: #selector(OperatorPresed), for: .touchUpInside)
            
        }
        
        lbResult.font = UIFont(name: "Helvetica", size: holder.frame.size.height * 0.10 ) // define o tamanho de fonte como 10% da tela
        // Define a posição da label como 6 linha e a altura como 20% da tela
        lbResult.frame = CGRect(x: 0, y: btZero.frame.origin.y - (btSize*6),
                                   width: view.frame.size.width, height: holder.frame.size.height * 0.20)
        holder.addSubview(lbResult)
        
        lbHistorico.font = UIFont(name: "Arial", size: holder.frame.size.height * 0.05 ) // define o tamanho de fonte como 5% da tela
        lbHistorico.frame = CGRect(x: 0, y: btZero.frame.origin.y - (btSize*7),
                                          width: view.frame.size.width, height: holder.frame.size.height * 0.10)
        holder.addSubview(lbHistorico)
        
    }// Fim setup keyPad
    
   
   
    
    // Comportamento referente ao clique em um botão numérico
    @objc func numPressed(_ sender: UIButton){
        let tag = sender.tag
        if lbResult.text == "0" {
            lbResult.text = String(tag)
        }
        else if tag == 20{
            lbResult.text = (lbResult.text ?? "") + "."
        }
        else {
            lbResult.text = (lbResult.text ?? "") + String(tag)
        }
        
    }
    
    //Controla a lógica matemárica das operaçòes
    @objc func OperatorPresed(_ sender: UIButton){
        let tag = sender.tag
        
        // testa se a lebel resulte tem texto, converte o texto para doubre e se operndo não é zeor
        if let text = lbResult.text, let value = Double(text), operando ==  0.0, let opDesejada = sender.titleLabel?.text{
            operando = value
            // zera o texto de resul para reeveber o operador
            addLblHistoryText(text: text + opDesejada)
            lbResult.text = "0"
            
        }
        
        // = pressionado
        if tag == 1{
            if let op = curretntOprentions{
                operador = 0.00
                if let text = lbResult.text, let value = Double(text){
                    operador = value
                    addLblHistoryText(text: text)
                }
            
            // Rezaliza as operações matemáticas
            switch op {
                case .add:
                let result = operando + operador
                //addLblHistoryText(text: String(operador))
                lbResult.text = "\(result)"
                
            case .sub:
                let result = operando - operador
                lbResult.text = "\(result)"
                
            case .times:
                let result = operando * operador
                lbResult.text = "\(result)"
                
            case .divide:
                if operando == 0{
                    lbResult.text = "Divisão por zero inválida"
                    break
                }
                let result = operando / operador
                lbResult.text = "\(result)"
            default:
                break
                }
            }
        }// Fim = pressioando
        
        // Operacoes matematicas
        else if tag == 2 {
            curretntOprentions = .add
            
        }
        else if tag == 3               {
            curretntOprentions = .sub
        }
        else if tag == 4{
            curretntOprentions = .times
        }
        
        else if tag == 5{
            curretntOprentions = .divide
        }
        
        else if tag == 6{ // AC
            lbResult.text = "0"
            lbHistorico.text = ""
            curretntOprentions = nil
            operando = 0.0
            operador = 0.0
        }
        else if tag == 7{ //troca sinal
            lbResult.text = "-"+lbResult.text!
        }
        
    }// Fim lógica matematica das operacoes
    
    
    func addLblHistoryText(text: String){
        if let currentText = lbHistorico.text {
            lbHistorico.text = currentText + text
        }
    }
}
