//
//  ViewController.swift
//  Foodies
//
//  Created by Majd Zaatri on 19/04/2020.
//  Copyright © 2020 Majd Zaatri. All rights reserved.
//

import UIKit
import paper_onboarding

class ViewController: UIViewController ,PaperOnboardingDataSource, PaperOnboardingDelegate{
    
    func onboardingItemsCount() -> Int {
        return 3
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        
        return [
            OnboardingItemInfo(
               informationImage: UIImage(named:"fridge")!,
               title: "WHAT'S IN MY FRIDGE?",
               description: "Find recipes that use as many of the ingredients you have available as possible while limiting missing ingredients.",
               pageIcon:  UIImage(),
               color: UIColor(red: 0.39, green: 0.31, blue: 0.35, alpha: 0.35),
               titleColor: UIColor.white,
               descriptionColor: UIColor.white,
               titleFont: UIFont(name: "Superclarendon-Regular", size: CGFloat(40))!,
               descriptionFont: UIFont(name: "PingFangSC-Regular", size: CGFloat(15))!),
            OnboardingItemInfo(
               informationImage: UIImage(named:"family")!,
               title: "Family members",
               description: "Shopping list will be available and synchronised with any family member.",
               pageIcon:  UIImage(),
               color: UIColor(red: 0.39, green: 0.31, blue: 0.35, alpha: 0.60),
               titleColor: UIColor.white,
               descriptionColor: UIColor.white,
               titleFont: UIFont(name: "Superclarendon-Regular", size: CGFloat(40))!,
               descriptionFont: UIFont(name: "PingFangSC-Regular", size: CGFloat(15))!),
            OnboardingItemInfo(
                informationImage: UIImage(named:"family")!,
                title: "MEAL PLANNING",
                description: "Plan your week with our meal planning.",
                pageIcon:  UIImage(),
                color: UIColor(red: 0.39, green: 0.31, blue: 0.35, alpha: 0.90),
                titleColor: UIColor.white,
                descriptionColor: UIColor.white,
                titleFont: UIFont(name: "Superclarendon-Regular", size: CGFloat(40))!,
                descriptionFont: UIFont(name: "PingFangSC-Regular", size: CGFloat(15))!)
            ][index]
        
    }
    

    @IBOutlet weak var onboardingView: OnboardingView!
    
    @IBOutlet weak var getStarted: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onboardingView.dataSource = self
        onboardingView.delegate = self
    }
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        
        if index == 1{
            if getStarted.alpha == 1 {
                UIView.animate(withDuration: 0.2) {
                    self.getStarted.alpha = 0
                }
            }
        }
    }
    
    func onboardingDidTransitonToIndex(_ index: Int) {
        if index == 2{
                     self.getStarted.alpha = 1
             }
    }

    @IBAction func gotStarted(_ sender: UIButton) {
        let userDefaults = UserDefaults.standard
        
        userDefaults.set(true, forKey: "onboardingComplete")

        userDefaults.synchronize()

    }
    
}

