//
//  main.swift
//  WebstersEnglishDictionary
//
//  Created by Matt Reagan on 11/12/16.
//  Copyright © 2016 Matt Reagan. All rights reserved.
//
//  This software is provided 'as-is', without any express or implied
//  warranty. In no event will the author be held liable for any damages
//  arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose,
//  including commercial applications, and to alter it and redistribute it
//  freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//     claim that you wrote the original software. If you use this software
//     in a product, an acknowledgment in the product documentation would be
//     appreciated but is not required.
//  2. Altered source versions must be plainly marked as such, and must not be
//     misrepresented as being the original software.
//  3. This notice may not be removed or altered from any source distribution.
//
//  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//
//  This project provides a simple utility for parsing the free Websters Unabridged
//  English Dictionary (available through the Gutenberg Project) into either a top
//  level Swift Dictionary object, or an Array of 26 dictionaries (one which for each
//  lowercase letter in the standard ASCII set between 97-122 inclusive).
//  
//  These objects are then serialized to a single JSON output file, so that they can
//  be easily read and used in any project that can parse standard JSON files.
//
//  For Mac and iOS, you may want to consider using Apple's DictionaryServices framework
//  for things like word definitions, however other projects may wish to leverage
//  a standard English dictionary for other purposes, and might find these files useful.
//
//  Note: if all you want is to make use of the dictionary JSON file itself, you
//  do not need to use this utility at all, the pre-processed JSON dictionaries
//  in several formats have been provided with the original GitHub repo.
//
//  This code is not intended to be especially performant, however the project itself
//  demonstrates a few things which may be of interest to newcomers to Swift:
//      1. Creating a command-line utility for Mac using Swift
//      2. Making use of CLI arguments
//      3. Text parsing with Scanner and CharacterSet

import Foundation

let asciiAlphaUppercase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ-"
let multiWordDefinitionSeparator = "; "
let definitionPrefix = "Defn: "
let definitionItemPrefixNumerical = "1."
let definitionItemPrefixAlphabetized = "(a)"

/*  Grab the arguments passed into the utility */
let arguments = CommandLine.arguments

/*  First argument is always the path to the executable */
if arguments.count != 3 {
    print("Dictionary utility expects exactly two arguments, an input dictionary file and an output file location.")
    
    exit(1)
}

let inputFilePath = arguments[1]
let outputFilePath = arguments[2]
let inputURL = URL.init(fileURLWithPath: inputFilePath)

guard let fileText = try String.init(data: Data.init(contentsOf: inputURL), encoding: String.Encoding.utf8) else {
    print("Couldn't read input dictionary text file")
    
    exit(1)
}

/*  Set up our progress reporting state for the utility */
let totalDictionaryLength = fileText.characters.count
let progressReportStep = 5.0 //Report progress every 5%
var lastProgressReport = 0.0

/*  Set up the scanner */
let scanner = Scanner.init(string: fileText)
var line: NSString? = nil
var didScan = false

/*  Set up our character set for finding the beginning of each word definition */
let allowableWordDefinitionCharacters = asciiAlphaUppercase + multiWordDefinitionSeparator
var wordDefinitionCharacterSet = CharacterSet.init(charactersIn: allowableWordDefinitionCharacters)
let wordDefinitionCharacterSetInverted = wordDefinitionCharacterSet.inverted
var wordTrimmingCharactersSet = CharacterSet.whitespacesAndNewlines
wordTrimmingCharactersSet.formUnion(CharacterSet.init(charactersIn: "-"))

/*  Prepare some basic state for our dictionary parsing */
var currentWord: String? = nil
var definition: String? = nil

/*  This can be changed in the Build Settings, if needed. If this
    flag is set, rather than 1 large JSON dictionary, the words
    and definitions are presorted into a set of 26 arrays, referenced
    by the first letter of the word. */
#if DICTIONARY_SORT_INTO_ALPHA_ARRAYS
    
var compiledDictionary: [[String: String]] = Array()
    
for i in 1...26 {
    var dictionary: [String: String] = Dictionary()
    compiledDictionary.append(dictionary)
}
    
#else
var compiledDictionary: [String: String] = Dictionary()
#endif

repeat {
    didScan = scanner.scanUpTo("\r\n", into: &line)
    
    guard let lineText = line else {
        continue
    }
    
    func finishCurrentWord() {
        if (currentWord != nil && definition != nil) {
            
            let cleanedDefinition = definition!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            
            /*  Some entries provide a definition for multiple words, e.g. WORDONE; WORDTWO */
            
            let allWords: [String] = currentWord!.components(separatedBy: ";")
            
            for aWord in allWords {
                let cleanedWord = aWord.trimmingCharacters(in: wordTrimmingCharactersSet
                    ).lowercased()
                
                if (cleanedWord.characters.count > 0) {
                    
                    /*  Avoid overwriting previously defined words, for duplicate entries. Append: */
                    
                    let letterALowercaseASCII = 97
                    
                    #if DICTIONARY_SORT_INTO_ALPHA_ARRAYS
                        let asciiValue = Int((cleanedWord as NSString).character(at: 0)) - letterALowercaseASCII
                        
                        assert(asciiValue >= 0 && asciiValue < 26, "Unexpected unicode value for first character of word \(cleanedWord)")
                        
                        if (compiledDictionary[asciiValue][cleanedWord] == nil) {
                            compiledDictionary[asciiValue][cleanedWord] = cleanedDefinition
                        } else {
                            compiledDictionary[asciiValue][cleanedWord] = compiledDictionary[asciiValue][cleanedWord]! + "\n\n" + cleanedDefinition
                        }
                        
                    #else
                        if (compiledDictionary[cleanedWord] == nil) {
                            compiledDictionary[cleanedWord] = cleanedDefinition
                        } else {
                            compiledDictionary[cleanedWord] = compiledDictionary[cleanedWord]! + "\n\n" + cleanedDefinition
                        }
                    #endif
                }
            }
        } else if (currentWord != nil && definition == nil) {
            /*  Ensure we're not warning about a duplicate entry, of which the dictionary has a few */
            
            #if DICTIONARY_SORT_INTO_ALPHA_ARRAYS
            #else
                if (compiledDictionary[currentWord!] == nil) {
                    print("No definition found for '\(currentWord!)'")
                }
            #endif
        }
    }
    
    func beginNewWord(word: String) {
        finishCurrentWord()
        currentWord = word
        definition = nil
    }
    
    func continueDefinition(text: String) {
        if (definition == nil) {
            definition = text
        } else {
            if (definition!.hasSuffix(" ")) {
                definition!.append(text)
            } else {
                definition!.append(" " + text)
            }
        }
    }
    
    func beginDefinition(text: String) {
        let cleanedText = lineText.substring(with: NSMakeRange(5, lineText.length - 5))
        
        continueDefinition(text: cleanedText)
    }
    
    func beginItemizedDefinition(text: String) {
        continueDefinition(text: text)
    }
    
    func hasItemizedDefinitionPrefix(text: String) -> Bool {
        return (text.hasPrefix(definitionItemPrefixNumerical) || text.hasPrefix(definitionItemPrefixAlphabetized))
    }
    
    let rangeOfInvalidForWordDefinition = lineText.rangeOfCharacter(from: wordDefinitionCharacterSetInverted)
    let lineTextString  = lineText as String
    
    if (rangeOfInvalidForWordDefinition.location == NSNotFound) {
        //We've hit a new word
        
        beginNewWord(word: lineTextString)
        
    } else if (lineText.hasPrefix(definitionPrefix)) {
        //We've begun a definition
        
        beginDefinition(text: lineTextString)
        
    } else if (hasItemizedDefinitionPrefix(text: lineTextString)) {
        //We've begun an itemized definition (some words do not have a 'Defn:' format)
        
        beginItemizedDefinition(text: lineTextString)
        
    } else if (definition != nil) {
        //We're in the midst of collecting the definition, continue
        
        continueDefinition(text: lineTextString)
    }
    else {
        //Discard line
    }
    
    if (!didScan) {
        finishCurrentWord()
    }
    
    let calculatedPercentComplete = 100.0 * (Double(scanner.scanLocation) / Double(totalDictionaryLength))
    
    if (calculatedPercentComplete > lastProgressReport + progressReportStep) {
        print("Progress: \(Int(calculatedPercentComplete))%")
        lastProgressReport = calculatedPercentComplete
    }
    
} while (didScan)

/*  Save out the dictionary as JSON */
if let outputStream = OutputStream.init(toFileAtPath: outputFilePath, append: false) {
    outputStream.open()
    JSONSerialization.writeJSONObject(compiledDictionary,
                                      to: outputStream,
                                      options: JSONSerialization.WritingOptions.prettyPrinted,
                                      error: nil)
    outputStream.close()
}

print("Finished. Output saved to: \(outputFilePath)")
