//
//  MoodBoardProfileViewController.swift
//  entrepreneurship-great-app
//
//  Created by Vinicius Alencar on 12/10/20.
//

import UIKit

class MoodBoardProfileViewController: UIViewController {

    @IBOutlet weak var soonLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        soonLabel.text = Translation.segmentedControl.soonMoodBoard
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
