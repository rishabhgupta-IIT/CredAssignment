//
//  DribbleViewController.swift
//  CredAssignment
//
//  Created by Rishabh Gupta on 2021-02-23.
//

import UIKit

class DribbleViewController: UIViewController {
    @IBOutlet private weak var stackView: UIStackView!
    
    var cardViews = [CardView]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        for index in 0..<4 {
            var state: CardState = .expanded
            if index == 1 {
                state = .bottomCollapsed
            }
            else if index > 1 {
                state = .hidden
            }
            
            let card =  CardView.view().withState(state)
            card.delegate = self
            cardViews.append(card)
            stackView.addArrangedSubview(card)
            card.isHidden = state == .hidden ? true : false
        }
        
        for (index, card) in cardViews.enumerated() {
            switch index {
            case 0:
                card.backgroundColor = .blue
            case 1:
                card.backgroundColor = .red
            case 2:
                card.backgroundColor = .green
            default:
                card.backgroundColor = .purple
            }
        }
    }
}

extension DribbleViewController: CardViewDelegate {
    func didTapOnCard(_ card: CardView) {
        if let indexOfTappedCard = self.cardViews.firstIndex(of: card) {
            for (eachIndex, eachCard) in self.cardViews.enumerated() {
                if eachIndex < indexOfTappedCard {
                    eachCard.setState(.topCollapsed)
                    eachCard.isHidden = false
                }
                else if eachIndex == indexOfTappedCard {
                    eachCard.setState(.expanded)
                    eachCard.isHidden = false
                }
                else if eachIndex == indexOfTappedCard+1 {
                    eachCard.setState(.bottomCollapsed)
                    eachCard.isHidden = false
                }
                else {
                    eachCard.setState(.hidden)
                    eachCard.isHidden = true
                }
            }
        }
    }
}
