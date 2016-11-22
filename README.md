# Webster's Unabridged English Dictionary

This repository contains *Webster's Unabridged English Dictionary* (from the [Gutenberg Project](www.gutenberg.net)) in several formats:

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

## Acknowledgments

- Original repository and Julia script provided by [https://github.com/adambom/dictionary](https://github.com/adambom/dictionary)
- Webster's Unabridged English Dictionary provided by [Project Gutenberg](http://www.gutenberg.net/)


## Author

**Matt Reagan** - Website: [http://sound-of-silence.com/](http://sound-of-silence.com/) - Twitter: [@hmblebee](https://twitter.com/hmblebee)


## License

The original dictionary text file is covered by The Gutenberg Project's licensing, please see the file headers for more details. The Swift parsing tool and example output files in this repository are free and distributed under the GNU General Public License, Version 2.
