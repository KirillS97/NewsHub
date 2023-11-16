//
//  CollectionViewController.swift
//  NewsHub
//
//  Created by Kirill on 15.11.2023.
//

import UIKit



class CollectionViewController: UICollectionViewController {
    
    
    private var windowSize: CGSize? {
        if let windowSceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? UIWindowSceneDelegate {
            if let sizeOfWindow = windowSceneDelegate.window??.frame.size {
                return sizeOfWindow
            }
        }
        return nil
    }
    
    private var customFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        return flowLayout
    }()
    
    override func loadView() {
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: customFlowLayout)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.backgroundColor = .systemGreen

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseId)

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 7
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseId, for: indexPath) as? CategoryCell {
            cell.setNameLabelText(text: "Name")
            return cell
        } else {
            let cell = CategoryCell()
            return cell
        }
    }

    // MARK: UICollectionViewDelegate
    
    

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}




extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(self.view.safeAreaLayoutGuide.layoutFrame.size)
        
        let safeAreaWidth = self.view.safeAreaLayoutGuide.layoutFrame.width
        let safeAreaHeight = self.view.safeAreaLayoutGuide.layoutFrame.height
        
        return CGSize(width: safeAreaWidth * 0.2, height: safeAreaWidth * 0.2)
    }
}
