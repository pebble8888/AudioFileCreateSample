//
//  ViewController.swift
//  AudioFileCreateSample
//
//  Created by pebble8888 on 2017/01/21.
//  Copyright © 2017年 pebble8888. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myAudioFile = MyAudioFile()
        myAudioFile.execute()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

