//
//  SpaceShip.swift
//  Pocket_Pet
//
//  Created by 林岳 on 11/15/18.
//  Copyright © 2018 Leiquan Pan. All rights reserved.
//

import Foundation

import UIKit
import ARKit

enum Emotion {
    case deadpool
    case original
    case happy
    case boring
    case hungry
    
    static let allValues = [hungry, happy, boring, deadpool, original]
}

class PetFigure: SCNNode {
    let MAX_VALUE = 100
    
    var prevFullness: Int = 50
    
    var fullness:Int = 50 {
        didSet {
            if fullness > MAX_VALUE {
                fullness = MAX_VALUE
            } else if fullness < 0 {
                fullness = 0
            }
            changeModel()
        }
    }
    var happiness:Int = 50 {
        didSet {
            if happiness > MAX_VALUE {
                happiness = MAX_VALUE
            } else if happiness < 0 {
                happiness = 0
            }
        }
    }
    
    override init() {
        idleModel = NORMAL_IDLE_MODEL
        clickedModel = CLICKED_MODEL
        curMaterialPath = EMOTION_ORIGINAL
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let HAPPY_IDLE_MODEL = "art.scnassets/DanceFixed.dae"
    let NORMAL_IDLE_MODEL = "art.scnassets/Donothing.dae"
    let ANGRY_IDLE_MODEL = "art.scnassets/HungryToDie.dae"
    let EAT_MODEL = "art.scnassets/HappyToEat.dae"
    let CLICKED_MODEL = "art.scnassets/touchHim.dae"
    let INIT_MODEL = "art.scnassets/touchToShow.dae"
    
    
    let EMOTION_DEADPOOL = "Deadpool_copy"
    let EMOTION_ORIGINAL = "Muhammer_copy"
    let EMOTION_HUNGRY = "hungry_copy"
    let EMOTION_BORING = "boring_copy"
    let EMOTION_HAPPY = "happy_copy"
    
    var curMaterialPath: String {
        didSet {
            loadModel()
        }
    }
    
    var idleModel: String {
        didSet {
            loadModel()
        }
    }

    var clickedModel: String
    
    var wrapperNode = SCNNode()
    
    func eatFood(food: Food) {
        
        switch food.identifier {
        case .brain:
            fullness = fullness + 16
            happiness = happiness + 20
        case .apple:
            fullness = fullness - 100
            happiness = happiness - 100
            idleModel = ANGRY_IDLE_MODEL
        case .pokemon:
            fullness = fullness + 10
            happiness = happiness + 15
        case .bone:
            fullness = fullness + 100
            happiness = happiness + 100
            idleModel = HAPPY_IDLE_MODEL
        }
        
        if fullness > MAX_VALUE {
            fullness = MAX_VALUE
        } else if fullness < 0 {
            fullness = 0
        }
        if happiness > MAX_VALUE {
            happiness = MAX_VALUE
        } else if happiness < 0 {
            happiness = 0
        }
        
        wrapperNode.removeFromParentNode()
        
        guard let virtualObjectScene = SCNScene(named: EAT_MODEL) else {return}
        
        wrapperNode = SCNNode()
        
        for child in virtualObjectScene.rootNode.childNodes {
            child.geometry?.firstMaterial?.diffuse.contents = UIImage(named: curMaterialPath)
            wrapperNode.addChildNode(child)
        }
        
        self.addChildNode(wrapperNode)
        // TODO: modify delay second to smooth movement
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
            self.loadModel()
        })
    }
    
    func show() {
        wrapperNode.removeFromParentNode()
        
        guard let virtualObjectScene = SCNScene(named: INIT_MODEL) else {return}
        
        wrapperNode = SCNNode()
        
        for child in virtualObjectScene.rootNode.childNodes {
            child.geometry?.firstMaterial?.diffuse.contents = UIImage(named: curMaterialPath)
            wrapperNode.addChildNode(child)
        }
        
        self.addChildNode(wrapperNode)
        // TODO: modify delay second to smooth movement
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.7, execute: {
            self.loadModel()
        })
    }
    
    func touched() {
        //change movement when
        wrapperNode.removeFromParentNode()
        
        guard let virtualObjectScene = SCNScene(named: clickedModel) else {return}
        
        wrapperNode = SCNNode()
        
        for child in virtualObjectScene.rootNode.childNodes {
            child.geometry?.firstMaterial?.diffuse.contents = UIImage(named: curMaterialPath)
            wrapperNode.addChildNode(child)
        }
        
        self.addChildNode(wrapperNode)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3) + 0.5, execute: {
            self.loadModel()
        })
    }
    
    // given index: 1: 
    func changeMaterial(emotion: Emotion) {
        switch emotion {
        case .deadpool:
            curMaterialPath = EMOTION_DEADPOOL
        case .boring:
            curMaterialPath = EMOTION_BORING
        case .happy:
            curMaterialPath = EMOTION_HAPPY
        case .hungry:
            curMaterialPath = EMOTION_HUNGRY
        case .original:
            curMaterialPath = EMOTION_ORIGINAL
        }
    }
    
    func loadModel() {
        //load ship
        wrapperNode.removeFromParentNode()
        
        guard let virtualObjectScene = SCNScene(named: idleModel) else {return}
        
        wrapperNode = SCNNode()
        
        for child in virtualObjectScene.rootNode.childNodes {
            child.geometry?.firstMaterial?.diffuse.contents = UIImage(named: curMaterialPath)
            
            wrapperNode.addChildNode(child)
        }
        
        self.addChildNode(wrapperNode)
    }
    
    func changeModel() {
        if prevFullness <= 80 && fullness > 80 {
            idleModel = HAPPY_IDLE_MODEL
        } else if (prevFullness >= 80 && fullness < 80) || (prevFullness <= 20 && fullness > 20) {
            idleModel = NORMAL_IDLE_MODEL
        } else if prevFullness >= 20 && fullness < 20 {
            idleModel = ANGRY_IDLE_MODEL
        }
        prevFullness = fullness
    }
    
    func decreaseFullness(degree: Int) {
        fullness = fullness - degree
        if fullness < 0 {
            fullness = 0
        }
    }
    
    func decreaseHappiness(degree: Int) {
        happiness = happiness - degree
        if happiness < 0 {
            happiness = 0
        }
        
    }
}
