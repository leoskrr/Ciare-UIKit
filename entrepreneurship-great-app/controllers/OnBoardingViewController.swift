//
//  OnBoardingViewController.swift
//  entrepreneurship-great-app
//
//  Created by Vinicius Alencar on 22/10/20.
//

import UIKit

class OnBoardingViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var continueButton: UIButton!
    
    var imagesArray:[UIImage?] = [UIImage(named:"mãos_peças"),UIImage(named:"menina_celular"),UIImage(named:"casal_emprend")]
    
    var titleArray: [String] = [
        Translation.Walkthrough.titleone,
        Translation.Walkthrough.titletwo,
        Translation.Walkthrough.titlethree]
    
    var descriptionArray: [String] = [
        Translation.Walkthrough.subtitleone,
        Translation.Walkthrough.subtitletwo,
        Translation.Walkthrough.subtitlethree]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnBoardCell", for: indexPath) as! OnBoardingCollectionViewCell
        
        cell.fillCell(image: imagesArray[indexPath.row], title: titleArray[indexPath.row], description: descriptionArray[indexPath.row])
        
        return cell
    }
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pageControl.numberOfPages = imagesArray.count
        continueButton.setTitle(Translation.Walkthrough.button, for: .normal)
        continueButton.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
           let userIsLogged = getUserLoggedInApplicationStatus()
                           
           if userIsLogged{
               let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let tabbarVC = storyboard.instantiateViewController(withIdentifier: "TabBarView") as! TabBarViewController
               
               self.definesPresentationContext = true
               tabbarVC.modalPresentationStyle = .overCurrentContext

               self.present(tabbarVC, animated: false, completion: nil)
               
               tabBarController?.tabBar.isHidden = true
           }
    }
    
    @IBAction func continueButtonSelected(_ sender: Any) {
        
    }
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
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        pageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        
        if pageControl.currentPage == 2 {
            continueButton.isHidden = false
        }else{
            continueButton.isHidden = true
        }
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {

        pageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        
        if pageControl.currentPage == 2 {
            continueButton.isHidden = false
        }else{
            continueButton.isHidden = true
        }
    }
}
