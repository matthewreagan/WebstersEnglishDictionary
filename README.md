# Webster's Unabridged English Dictionary

---

## ⚠️ Important

This repo is not an actively-maintained mirror for Webster's English dictionary, it is for a JSON parsing tool for the dictionary data itself. Although the repo _does_ include a copy of Webster's English dictionary, as noted below it is the 2009 version provided by the Gutenberg project and has known errors and omissions. Please visit the [Gutenberg Website](https://www.gutenberg.org/) if you wish to find the latest available version of the dictionary file.

--- 

This repository contains [*Webster's Unabridged English Dictionary*](https://www.gutenberg.org/ebooks/29765) (from the [Gutenberg Project](https://www.gutenberg.org/), compiled August 22, 2009) in several formats:

| Format | File |
| --- | --- |
| Original dictionary text file |**WebstersEnglishDictionary.txt** |
| JSON file (compact, reduced whitespace) | **dictionary_compact.json** |
| JSON file (includes linebreaks, slightly more readable) | **dictionary.json** |
| JSON file as array of 26 dictionaries (A-Z) | **dictionary_alpha_arrays.json** |

It aims to improve upon the output of similar projects such as [adambom/dictionary](https://github.com/adambom/dictionary), and also provide a parsing utility written in [Swift](http://www.apple.com/swift/), which converts the original dictionary definitions into Swift objects which are then serialized using `JSONSerialization`.

## Notes

- If you only wish to use the dictionary JSON files, you do not need to run the Xcode project or command line tool, simply download one or more of the above files
- If you are developing for Mac or iOS, be sure to look at Apple's `DictionaryServices` framework. The files here are intended for projects that wish to make direct use of the standard English dictionary outside of such frameworks

## Usage (Command Line Utility)

- The utility takes two arguments: an input path to the original dictionary text, and an output path for the JSON file

Example: `./WebstersEnglishDictionary WebstersEnglishDictionary.txt ~/Documents/dictionaryAsJSON.json`

## Usage (JSON Files)

- The JSON files can be used as-is. Any project which can parse JSON should be able to read and process these files
- Keep in mind that the size of these files is significant: you may wish to implement your own optimizations to either the output (for improved sorting / lookup) or compression if you are including the files in bundled applications

## Formatting
#### `dictionary.json`
A single object of all words and definitions:
```json
{
  "anopheles" : "A genus of mosquitoes which are secondary hosts of the malaria parasites, and whose bite is the usual, if not the only, means of infecting human beings with malaria. Several species are found in the United States. They may be distinguished from the ordinary mosquitoes of the genus Culex by the long slender palpi, nearly equaling the beak in length, while those of the female Culex are very short. They also assume different positions when resting, Culex usually holding the body parallel to the surface on which it rests and keeping the head and beak bent at an angle, while Anopheles holds the body at an angle with the surface and the head and beak in line with it. Unless they become themselves infected by previously biting a subject affected with malaria, the insects cannot transmit the disease.",
  "uniclinal" : "See Nonoclinal.",
  "sarong" : "A sort of petticoat worn by both sexes in Java and the Malay Archipelago. Balfour (Cyc. of India)",
```

#### `dictionary_alpha_arrays.json`
An array of 26 objects, for each leading letter:
```json
[
  {
    "anarchic" : "Pertaining to anarchy; without rule or government; in political confusion; tending to produce anarchy; as, anarchic despotism; anarchical opinions.",
    "anopheles" : "A genus of mosquitoes which are secondary hosts of the malaria parasites, and whose bite is the usual, if not the only, means of infecting human beings with malaria. Several species are found in the United States. They may be distinguished from the ordinary mosquitoes of the genus Culex by the long slender palpi, nearly equaling the beak in length, while those of the female Culex are very short. They also assume different positions when resting, Culex usually holding the body parallel to the surface on which it rests and keeping the head and beak bent at an angle, while Anopheles holds the body at an angle with the surface and the head and beak in line with it. Unless they become themselves infected by previously biting a subject affected with malaria, the insects cannot transmit the disease.",
    "anti-federalist" : "One of party opposed to a federative government; -- applied particularly to the party which opposed the adoption of the constitution of the United States. Pickering.",
```

#### `dictionary_compact.json`
Same format as `dictionary.json`, with extraneous whitespace removed:
```json
{"anopheles":"A genus of mosquitoes which are secondary hosts of the malaria parasites, and whose bite is the usual, if not the only, means of infecting human beings with malaria. Several species are found in the United States. They may be distinguished from the ordinary mosquitoes of the genus Culex by the long slender palpi, nearly equaling the beak in length, while those of the female Culex are very short. They also assume different positions when resting, Culex usually holding the body parallel to the surface on which it rests and keeping the head and beak bent at an angle, while Anopheles holds the body at an angle with the surface and the head and beak in line with it. Unless they become themselves infected by previously biting a subject affected with malaria, the insects cannot transmit the disease.","uniclinal":"See Nonoclinal.","sarong":"A sort of petticoat worn by both sexes in Java and the Malay Archipelago. Balfour (Cyc. of India)",
```

## Acknowledgments

- Original repository and Julia script provided by [https://github.com/adambom/dictionary](https://github.com/adambom/dictionary)
- Webster's Unabridged English Dictionary provided by [Project Gutenberg](http://www.gutenberg.org/)


## Author

**Matt Reagan** - Website: [http://sound-of-silence.com/](http://sound-of-silence.com/) - Twitter: [@hmblebee](https://twitter.com/hmblebee)


## License

The original dictionary text file is covered by The Gutenberg Project's licensing, please see the file headers for more details. The Swift parsing tool and example output files in this repository are free and distributed under the GNU General Public License, Version 2.
