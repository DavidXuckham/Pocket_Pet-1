//
//  File.swift
//  Pocket_Pet
//
//  Created by Leiquan Pan on 12/2/18.
//

import Foundation

import UIKit
import ARKit

class Arrorw: SCNNode {
    
    func loadModel() {
        //load apple
        guard let virtualObjectScene = SCNScene(named: "art.scnassets/arrow.dae") else {return}
        
        let wrapperNode = SCNNode()
        
        for child in virtualObjectScene.rootNode.childNodes {
            wrapperNode.addChildNode(child)
        }

        self.addChildNode(wrapperNode)
        
    }
}
