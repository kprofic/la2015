//
//  ViewController.swift
//  Voter
//
//  Created by Krzysztof Profic on 14/12/14.
//  Copyright (c) 2014 Lambda Academy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XYPieChartDataSource {
    lazy var vm: VoteManager = {
       return VoteManager.sharedInstance
    }()
    @IBOutlet weak var pieChart: XYPieChart!
    @IBOutlet weak var loveButton: UIButton!
    @IBOutlet weak var neutralButton: UIButton!
    @IBOutlet weak var hateButton: UIButton!
    
    @IBOutlet weak var likeWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var likeHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var neutralWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var neutralHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var hateWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var hateHeightConstraint: NSLayoutConstraint!
    
    // Life cycle
    override func viewDidLoad() {
        self.pieChart.reloadData()
    }
    
    // Actions
    @IBAction func smileButtonPressed(sender: UIButton) {
        self.vm.makeVote(Vote.Like)
        self.animateButton(sender)
        self.pieChart.reloadData();
    }
    
    @IBAction func donnoPressed(sender: UIButton) {
        self.vm.makeVote(Vote.Neutral)
        self.animateButton(sender)
        self.pieChart.reloadData();
    }
    
    @IBAction func cryingPressed(sender: UIButton) {
        self.vm.makeVote(Vote.Hate)
        self.animateButton(sender)
        self.pieChart.reloadData();
    }
    
    // Animation
    
    func animateButton(btn : UIButton) {
        var width: NSLayoutConstraint! = {
            switch (btn) {
            case self.loveButton :
                return self.likeWidthConstraint
            case self.neutralButton:
                return self.neutralWidthConstraint
            case self.hateButton:
                return self.hateWidthConstraint
            default: ()
            }
            return nil
        }()
        
        var height: NSLayoutConstraint! = {
            switch (btn) {
            case self.loveButton :
                return self.likeHeightConstraint
            case self.neutralButton:
                return self.neutralHeightConstraint
            case self.hateButton:
                return self.hateHeightConstraint
            default: ()
            }
            return nil
        }()
        
        
        UIView.animateWithDuration(0.2, animations: {
            width.constant*=2;
            height.constant*=2;
            btn.layoutIfNeeded()
        }, completion: { _ in
            
            UIView.animateWithDuration(0.5, animations: {
                width.constant/=2;
                height.constant/=2;
                btn.layoutIfNeeded()
            })
        })
    }
    
    // Pie Chart
    func numberOfSlicesInPieChart(pieChart: XYPieChart!) -> UInt {
        return 3
    }
    
    func pieChart(pieChart: XYPieChart!, valueForSliceAtIndex index: UInt) -> CGFloat {
        switch (index) {
        case 0:
            return CGFloat(self.vm.likes().count)
        case 1:
            return CGFloat(self.vm.neutrals().count)
        case 2:
            return CGFloat(self.vm.hates().count)
        default:
            return 0
        }
    }
    
    func pieChart(pieChart: XYPieChart!, colorForSliceAtIndex index: UInt) -> UIColor! {
        switch (index) {
        case 0:
            return UIColor.greenColor().colorWithAlphaComponent(0.6)
        case 1:
            return UIColor.blueColor().colorWithAlphaComponent(0.6)
        case 2:
            return UIColor.redColor().colorWithAlphaComponent(0.6)
        default:
            return nil
        }
    }
}

