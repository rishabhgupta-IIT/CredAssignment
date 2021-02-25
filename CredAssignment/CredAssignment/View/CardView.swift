//
//  CardView.swift
//  CredAssignment
//
//  Created by Rishabh Gupta on 2021-02-25.
//

import UIKit

enum CardState {
    case expanded
    case hidden
    case topCollapsed
    case bottomCollapsed
}

protocol CardViewDelegate: class {
    func didTapOnCard(_ card: CardView)
}

class CardView: UIView {
    
    @IBOutlet weak private var stackView: UIStackView!
    @IBOutlet weak private var topCollapsedView: UIView!
    @IBOutlet weak private var expandedView: UIView!
    @IBOutlet weak private var bottomCollapsedView: UIView!
    
    @IBOutlet weak private var topCollapsedLabel: UILabel!
    @IBOutlet weak private var centerExpandedLabel: UILabel!
    @IBOutlet weak private var bottomCollapsedLabel: UILabel!
    
    weak var delegate: CardViewDelegate?

    var state: CardState = .hidden
    
    static func view() -> CardView {
        let cardNib = UINib.init(nibName: "CardView", bundle: .main)
        let cardView = cardNib.instantiate(withOwner: nil, options: nil)[0] as! CardView
        return cardView
    }
    
    private func setupUI() {
        switch state {
        case .expanded:
            topCollapsedView.isHidden = true
            expandedView.isHidden = false
            bottomCollapsedView.isHidden = true
            
            topCollapsedLabel.alpha = 0
            centerExpandedLabel.alpha = 1
            bottomCollapsedLabel.alpha = 0
            
        case .hidden:
            topCollapsedView.isHidden = true
            expandedView.isHidden = true
            bottomCollapsedView.isHidden = true
            
            topCollapsedLabel.alpha = 0
            centerExpandedLabel.alpha = 0
            bottomCollapsedLabel.alpha = 0
            
        case .topCollapsed:
            topCollapsedView.isHidden = false
            expandedView.isHidden = true
            bottomCollapsedView.isHidden = true
            
            topCollapsedLabel.alpha = 1
            centerExpandedLabel.alpha = 0
            bottomCollapsedLabel.alpha = 0
            
        case .bottomCollapsed:
            topCollapsedView.isHidden = true
            expandedView.isHidden = true
            bottomCollapsedView.isHidden = false
            
            topCollapsedLabel.alpha = 0
            centerExpandedLabel.alpha = 0
            bottomCollapsedLabel.alpha = 1
        }

    }
    
    func withState(_ state: CardState) -> Self {
        self.state = state
        setupUI()
        return self
    }
    
    func setState(_ state: CardState) {
        self.state = state
        setupUI()
    }
    
    @IBAction func topviewTapped(_ sender: UIButton) {
        cardViewTapped()
    }
    
    @IBAction func bottomviewTapped(_ sender: UIButton) {
        cardViewTapped()
    }
    
    private func cardViewTapped() {
        delegate?.didTapOnCard(self)
    }
}


