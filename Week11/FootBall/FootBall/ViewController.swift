//
//  ViewController.swift
//  FootBall
//
//  Created by Zoha on 8/10/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var playButton: UIButton!
  @IBOutlet weak var kickButton: UIButton!
  @IBOutlet weak var dropButton: UIButton!
  @IBOutlet weak var bigButton: UIButton!

  @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
  @IBOutlet weak var leftConstraint: NSLayoutConstraint!
  @IBOutlet weak var rightConstraint: NSLayoutConstraint!

  @IBOutlet weak var footballImage: UIImageView!
  private var animations: Set<Action> = []

  private var isButtonOpen = false

  override func viewDidLoad() {
    super.viewDidLoad()
    
    bottomConstraint.constant = -50
    leftConstraint.constant = -50
    rightConstraint.constant = -50

    playButton.layer.cornerRadius = 25
    kickButton.layer.cornerRadius = 25
    dropButton.layer.cornerRadius = 25
    bigButton.layer.cornerRadius = 25
  }

  @IBAction func onPlay(_ sender: Any) {
    let constraintConstant:CGFloat = isButtonOpen ? -50 : 50
    bottomConstraint.constant = constraintConstant
    leftConstraint.constant = constraintConstant
    rightConstraint.constant = constraintConstant

    UIView.animate(withDuration: 0.4) {
      self.view.layoutIfNeeded()
    }

    if isButtonOpen {

      if animations.contains(.kick){
        let translateY: CGFloat = animations.contains(.big) ? -150 : -250

        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 10, animations: {
          self.footballImage.transform = .init(translationX: 0, y: translateY)
        })

        UIView.animate(withDuration: 2, delay: 1, animations: {
          self.footballImage.transform = .init(translationX: 0, y: 0)
        })
      }

      if animations.contains(.big){
        UIView.animate(withDuration: 1) {
          self.footballImage.transform = .init(scaleX: 2.5, y: 2.5)
        }

        UIView.animate(withDuration: 2, delay: 1, animations: {
          self.footballImage.transform = .init(scaleX: 1, y: 1)
        })
      }

      if animations.contains(.blink){
        UIView.animate(withDuration: 0.25, delay: 0, animations: {
          UIView.modifyAnimations(withRepeatCount: 4, autoreverses: true, animations: {
            self.footballImage.alpha = 0
          })
        }, completion: { _ in
          self.footballImage.alpha = 1
        })
      }

      animations.removeAll()
    }

    isButtonOpen = !isButtonOpen
  }
  @IBAction func onKick(_ sender: Any) {
    animations.insert(.kick)
  }

  @IBAction func onBlink(_ sender: Any) {
    animations.insert(.blink)
  }

  @IBAction func onBig(_ sender: Any) {
    animations.insert(.big)
  }
}

enum Action {
  case kick, blink, big
}

