# mediatracker  

Searchable database of information about your media collection. It's meant to help you locate particular items wherever you have them stored. It isn't a media player or playlist generator. This project comprises a small application intended to be deployed to a cloud service to expose RESTful APIs to search the database.

For example, assume you have a large collection of jazz recordings, and you'd like to find all the recordings in your collection that feature Charlie Parker a a soloist. Similarly, if you have a classical collection, you might want to hear any recordings of Shostakovich symphonies that were performed under the direction of Leonard Bernstein. Or maybe you have an old song in your head and you can't remember the name of the band or the title, but you're hearing lyrics like "this is not my beautiful house."

It isn't easy to locate specific recordings using criteria like those. You end up digging through stacks of CDs, vinyl records, home-made recordings of live performances that might not be labeled, and mp3 files scattered across multiple devices or SD cards which are, themselves, buried somewhere in the general mess. By the time you find what you're looking for (if ever), you're no longer in the mood to listen to Charlie Parker.

This application is intended to help you locate those recordings in your vast collection of assorted media. Actually, that's not quite true. It's intended to help _me_ locate such recordings from _my_ collection in _my_ mess. But you can use it, too.

This project alone doesn't provide a complete solution. It only includes database search functionality exposed through APIs. It is not a general-purpose CRUD app for maintaining the database, nor does it provide a user-friendly GUI for searching the database. And that's okay, as it would be pretty tedious to enter details of each recording one by one through an HTML form. The idea is to bulk-load the database offline in batch mode via a SQL script or some other mechanism (out of scope for this project). Then you can write a client app to call the APIs, or use the universal RESTful client, cURL.

## The code  

The app was developed with Ruby, Sinatra, and Sqlite.

Please refer to the [developer notes](DeveloperNotes.md) for information about working on the code.
