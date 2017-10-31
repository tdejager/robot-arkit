//
//  Robot.swift
//  ARKitBasics
//
//  Created by Bas Zalmstra on 31/10/2017.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation
import SceneKit

class Robot : SCNNode {
  
  var base:SCNNode!;
  var shoulder:SCNNode!;
  var upperarm:SCNNode!;
  var wrist1:SCNNode!;
  var wrist2:SCNNode!;
  var wrist3:SCNNode!;
  var forearm:SCNNode!;
  
  /* Xcode required this */
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init() {
    super.init()
    
    self.base = self.createPart(name: "base.dae")
    self.shoulder = self.createPart(name: "shoulder.dae")
    self.upperarm = self.createPart(name: "upperarm.dae")
    self.wrist1 = self.createPart(name: "wrist1.dae")
    self.wrist2 = self.createPart(name: "wrist2.dae")
    self.wrist3 = self.createPart(name: "wrist3.dae")
    self.forearm = self.createPart(name: "forearm.dae")
    
    self.wrist2.addChildNode(self.wrist3)
    self.wrist1.addChildNode(self.wrist2)
    self.forearm.addChildNode(self.wrist1)
    self.upperarm.addChildNode(self.forearm)
    self.shoulder.addChildNode(self.upperarm)
    self.base.addChildNode(self.shoulder)
    self.addChildNode(base)
    
    self.updateFromJoints(joints: [-1.60, -1.73, -2.20, -0.81, 1.60, -0.03])
  }
  
  public func updateFromJoints(joints: [Float]) {
    self.shoulder.transform = SCNMatrix4Mult(SCNMatrix4MakeRotation(joints[0], 1.0, 0.0, 0.0), SCNMatrix4MakeTranslation(0.0, 0.1273, 0.0))
    self.upperarm.transform = SCNMatrix4Mult(SCNMatrix4MakeRotation(1.570796325+joints[1], 0.0, 0.0, -1.0), SCNMatrix4MakeTranslation(0.0, 0.0, -0.220941))
    self.forearm.transform = SCNMatrix4Mult(SCNMatrix4MakeRotation(0+joints[2], 1.0, 0.0, 0.0), SCNMatrix4MakeTranslation(0.0, 0.612, 0.1719))
    self.wrist1.transform = SCNMatrix4Mult(SCNMatrix4MakeRotation(1.570796325+joints[3], 0.0, 0.0, -1.0), SCNMatrix4MakeTranslation(0.0, 0.5723, 0.0))
    self.wrist2.transform = SCNMatrix4Mult(SCNMatrix4MakeRotation(0+joints[4], 1.0, 0.0, 0.0), SCNMatrix4MakeTranslation(0.0, 0.0, -0.1149))
    self.wrist3.transform = SCNMatrix4Mult(SCNMatrix4MakeRotation(0+joints[5], 1.0, 0.0, 0.0), SCNMatrix4MakeTranslation(0.0, 0.1157, 0.0))
  }
  
  private func createPart(name:String)->SCNNode {
    let partNode = SCNNode()
    let scene = SCNScene(named: name, inDirectory: "Assets.scnassets").unsafelyUnwrapped
    for part in scene.rootNode.childNodes {
      partNode.addChildNode(part)
    }
    return partNode
  }
}
