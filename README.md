# Pleco Anki

Hello! This is a project for specifically learning Chinese Vocabulary via [Pleco](https://www.pleco.com/) and [Anki](https://apps.ankiweb.net/)!

## Intro to Pleco and Anki & Motivations for this Project

For some quick background, Pleco is a widely used Chinese-English dictionary app that is very popular and contains a lot of useful tooling and resources for looking up English translations of Chinese words and phrases. One thing that Pleco does really well, is that there are a large variety of example sentences for most word definitions, giving good context into how a word should be used. (sometimes the examples are a pain to understand but usually they are pretty good)

Anki is a spaced reptition flashcard app that is very supported and widely used. The most common use case is for medical students trying to memorize all medical knowledge under the sun, but a great deal of people also use it for learning languages. Spaced repitition means that as you learn the various flash cards in your deck, it will adjust the interval/frequency you see the flash card based on how often you get the answer to the card. For example if you just learned a new word, it will show it to you 10 minutes after you get it correct; if you get it right again it will come back 1 day later; correct again 3 days later; correct again 6 days later; wrong you get it again in a few minutes, and after geting it correct it comes back tomorrow. For me this really solves the problem of learning a Chinese phrase for a month/limited period of time, but never remembering it. Do note that consistency is key, ideally you do this everyday but if you skip too much you end up having 900 cards due and the space repitition is definitely less useful then.

Anki is pretty flexible, so you can create your own flashcards for whatever topic you can think of and you can find a lot of user made flash card decks online. For Chinese, however I couldn't find a deck with good example sentences, most definitions in Anki decks use [CC-CEDICT](https://www.mdbg.net/chinese/dictionary?page=cc-cedict) or something similar which is okay, but I didn't like the lack of example sentences and lack of parts of speech. Also many decks are based on the [Hanyu Shuiping Kaoshi](https://en.wikipedia.org/wiki/Hanyu_Shuiping_Kaoshi) (HSK) Chinese literacy word list, but the one I initially started using dropped half the words randomly! At the end of the day I was tired of having an incomplete deck and definitions that weren't up to par. 

This project was to build an Anki Deck based on the new HSK 3.0 wordlist released in 2021 using definitions from Pleco. Pleco has their own flashcard system and on Android there is even an option to generate an Anki Flashcard for any given phrase (if you pay $10 for the extension). Only issue was there is no way to programmatically create flashcards for a long set of words (around 11k), the only option for creating flashcards was manually searching up the words in Pleco, and clicking the **\<create flashcard\>** button. Thus the project was born.

1. Emulate Android via BlueStacks and download Pleco + AnkiDroid
2. Write an AutoHotKey script to manually search/click through 11k HSK 3.0 words
3. Discover that due to lag & timing errors you're missing ~2k words
4. Load exported Anki Decks as a Sqlite Database (with much help from the [ankidroid schema](https://github.com/ankidroid/Anki-Android/wiki/Database-Structure)) to identify missing words
5. Backfill missing ~2k words
6. Run a second backfill since words are still missing
7. Write a script to format and generate meta data for each card (ie. add hsk level tags)

And voila, now you have a beautiful working, Anki Deck of HSK 3.0 words with Pleco definitions.

## Using Anki and the Generated Deck

Get the l