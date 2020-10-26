//
//  OnBoardingViewController.swift
//  entrepreneurship-great-app
//
//  Created by Vinicius Alencar on 22/10/20.
//

import UIKit

class OnBoardingViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var imagesArray:[UIImage?] = [UIImage(named:"mãos_peças"),UIImage(named:"menina_celular"),UIImage(named:"casal_emprend")]
    
    var titleArray: [String] = [Translation.Walkthrough.titleone, Translation.Walkthrough.titletwo, Translation.Walkthrough.titlethree]
    
    var descriptionArray: [String] = [Translation.Walkthrough.subtitleone, Translation.Walkthrough.subtitletwo, Translation.Walkthrough.subtitlethree]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OnBoardingCollectionViewCell
        
        cell.fillCell(image: imagesArray[indexPath.row], title: titleArray[indexPath.row], description: descriptionArray[indexPath.row])
        
        return cell
    }
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

extension OnBoardingViewController: UIScrollViewDelegate {
    

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.right, y: scrollView.contentInset.top)
        
        targetContentOffset.pointee = offset
    }
    
    
}

   
