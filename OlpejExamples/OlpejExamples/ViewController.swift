//
//  ViewController.swift
//  OlpejExamples
//
//  Created by Luke Sutton on 7/07/2016.
//  Copyright © 2016 Luke Matthew Sutton. All rights reserved.
//

import UIKit
import Olpej

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button1 = Olpej.button(
            .identifier("button-1"),
            .title("First", forState: .Normal),
            .backgroundColor(.blueColor()),
            .frame(x: 20, y: 20, width: 100, height: 50)
        )

        let button2 = Olpej.button(
            .identifier("button-2"),
            .title("Second", forState: .Normal),
            .backgroundColor(.redColor()),
            .frame(x: 20, y: 20, width: 100, height: 50)
        )

        let stack = Olpej.stackView(
            .identifier("stack"),
            .alignment(.Fill),
            .axis(.Horizontal),
            .distribution(.FillEqually),
            .frame(x: 20, y: 20, width: 300, height: 400)
        ).append([button1, button2])
        
        view.addSubview(stack.render())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

