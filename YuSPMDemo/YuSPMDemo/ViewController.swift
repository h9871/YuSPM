//
//  ViewController.swift
//  YuSPMDemo
//
//  Created by yuhyeonjae on 2022/03/28.
//

import UIKit

class ViewController: UIViewController {

    /// 콜렉션 뷰
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
    }
}

// MARK: - ㄴ 뷰 셋팅
extension ViewController {
    /// 뷰 생성
    private func initView() {
        
    }
    
    /// 뷰 레이아웃 설정
    private func updateLayout() {
        
    }
    
    /// 컬렉션 뷰 초기화
    private func initCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    /// 초기 뷰 로드
    private func initViewLoad() {
        
    }
}

// MARK: - ㄴ 콜렉션 뷰 관련 설정
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

