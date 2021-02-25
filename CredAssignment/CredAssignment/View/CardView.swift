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
            topCollapsedLabel.alpha = 0
            centerExpandedLabel.alpha = 1
            bottomCollapsedLabel.alpha = 0
            UIView.animate(withDuration: 1) {
                if !self.topCollapsedView.isHidden {
                    self.topCollapsedView.isHidden = true
                }
                
                self.expandedView.isHidden = false
                
                if !self.bottomCollapsedView.isHidden {
                    self.bottomCollapsedView.isHidden = true
                }
            }
            
        case .hidden:
            topCollapsedLabel.alpha = 0
            centerExpandedLabel.alpha = 0
            bottomCollapsedLabel.alpha = 0
            UIView.animate(withDuration: 1) {
                if !self.topCollapsedView.isHidden {
                    self.topCollapsedView.isHidden = true
                }
                
                if !self.expandedView.isHidden {
                    self.expandedView.isHidden = true
                }
                
                if !self.bottomCollapsedView.isHidden {
                    self.bottomCollapsedView.isHidden = true
                }
            }
            
        case .topCollapsed:
            
            topCollapsedLabel.alpha = 1
            centerExpandedLabel.alpha = 0
            bottomCollapsedLabel.alpha = 0
            
            UIView.animate(withDuration: 1) {
                self.topCollapsedView.isHidden = false
                
                if !self.expandedView.isHidden {
                    self.expandedView.isHidden = true
                }
                
                if !self.bottomCollapsedView.isHidden {
                    self.bottomCollapsedView.isHidden = true
                }
            }
            
        case .bottomCollapsed:
            
            topCollapsedLabel.alpha = 0
            centerExpandedLabel.alpha = 0
            bottomCollapsedLabel.alpha = 1
            
            UIView.animate(withDuration: 1) {
                if !self.topCollapsedView.isHidden {
                    self.topCollapsedView.isHidden = true
                }
                
                if !self.expandedView.isHidden {
                    self.expandedView.isHidden = true
                }
                
                self.bottomCollapsedView.isHidden = false
            }
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


