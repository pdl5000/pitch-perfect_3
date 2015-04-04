//
//  RecordedAudio.swift
//  PitchPerfect2
//
//  Created by Paul Lemelle on 3/22/15.
//  Copyright (c) 2015 Paul Lemelle. All rights reserved.
//
// Acts as the Model (MVC) for the program. 

import Foundation

class RecordedAudio: NSObject {
    var filePathUrl: NSURL!
    var title: String!
    
    init(_filePathUrl : NSURL!, _title : String!) {
        self.filePathUrl = _filePathUrl
        self.title = _title
        
    }
}



