//
//  OnboardingViewController.swift
//  app-ios
//
//  Created by LEONARDO LUIZ SILVA SANTOS on 23/11/21.
//

import UIKit

final class OnboardingViewController: UIViewController {

    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    var slides: [OnboardingSlide] = []
    var currentPage: Int = 0 {
        didSet{
            // last slide
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextButton.setTitle("Começar", for: .normal)
            } else if currentPage == 0 {
                nextButton.setTitle("Próximo", for: .normal)
                prevButton.setTitle("Pular", for: .normal)
            } else {
                nextButton.setTitle("Próximo", for: .normal)
                prevButton.setTitle("Anterior", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appName = "MPT Notícias"
        slides.append(OnboardingSlide(title: appName, description: "Obrigado por usar o MPT Notíciias o seu aplicaitvo com as novidades da atuação do  Minitério público do trabalho. ", image:  "onboarding-1.png"))
        slides.append(OnboardingSlide(title: appName, description: "No MPT NOTÍCIAS você vai ficar informado com as novidades sobre  o combate ao Trabalho escravo, sobre o combate ao trabalho infantil e todas as areas de atuação do MPT.", image:  "onboarding-2.png"))
        slides.append(OnboardingSlide(title: appName, description: "There is no one who loves pain itself, who seeks after it and wants to have it, simply because it is pain...", image:  "onboarding-3.png"))
    
    }

    @IBAction func prevBtnClicked(_ sender: Any) {
        if currentPage == 0 {
            self.performSegue(withIdentifier: "segueHome", sender: nil)
        } else {
            currentPage -= 1
            let rect = self.collectionView.layoutAttributesForItem(at: IndexPath(row: currentPage, section: 0))?.frame
             self.collectionView.scrollRectToVisible(rect!, animated: false)
           
        }
        
    }
    @IBAction func nextBtnClicked(_ sender: Any) {
        if currentPage == slides.count - 1 {
            self.performSegue(withIdentifier: "segueHome", sender: nil)
        } else {
            currentPage += 1
            let rect = self.collectionView.layoutAttributesForItem(at: IndexPath(row: currentPage, section: 0))?.frame
             self.collectionView.scrollRectToVisible(rect!, animated: false)
           
        }
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OnboardingCollectionViewCell
        
        cell.setup(Com: slides[indexPath.row])
        
        return cell
    }
    // for the slider fit in the screen
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
       
    }
    
    
}
