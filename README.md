# Webster's Instagram Accounts

A simple scraping project to identify available single-word usernames on Instagram.

A JSON version of [*Webster's Unabridged English Dictionary*](https://www.gutenberg.org/ebooks/29765) parsed by [matthewreagan](https://github.com/matthewreagan) is used as a resource of singluar words. You can find his parsing utility on github [*here*](https://github.com/matthewreagan/WebstersEnglishDictionary).

If you want to, you could replace the dictionary with your own reference material as a resource of usernames to look up.

## Formatting of JSON file (Inherited from [matthewreagan](https://github.com/matthewreagan))
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

- Webster's Unabridged English Dictionary provided by [Project Gutenberg](http://www.gutenberg.net/)
- Webster's Unabridged English Dictionary in JSON format, produced by [*matthewreagan/WebstersEnglishDictionary*](https://github.com/matthewreagan/WebstersEnglishDictionary).
