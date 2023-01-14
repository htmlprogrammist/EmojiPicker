# Contributing

Here provided more info about project, contribution process and recomended changes.
Please, read it before pull request or create issue.

## Codestyle 

### Marks

For clean struct code good is using marks. 

```swift
class Example {

    // MARK: - Init
    
    init() {}
}
```

Here you find all which using in project:

- // MARK: - Init
- // MARK: - Life Cycle
- // MARK: - Public Properties
- // MARK: - Public Methods
- // MARK: - Private Properties
- // MARK: - Private Methods
- // MARK: - Ovveride
- // MARK: - Layout
- // MARK: - Models

If you can't find valid, add new to codestyle agreements please. Other can be use if class is large and need struct it even without adding to codestyle agreements.

## Conventional Commits

- Commit names should be according to the [guideline](https://github.com/htmlprogrammist/EmojiPicker/blob/main/CONTRIBUTING.md#guideline)
- The present tense should be used ("add function", not "added function")
- The imperative mood should be used ("move the cursor to...", not "move the cursor to...")

### Guideline

- `init:` - used to start a project. Examples:
    
    ```
    init: start youtube-task
    init: start mentor-dashboard task
    ```
    
- `feat:` - this is the implemented new functionality from the terms of reference (added zoom support, added footer, added a product card). Examples:
    
    ```
    feat: add basic page layout
    feat: implement search box 
    feat: implement request to youtube API
    feat: implement swipe for horizontal list
    feat: add additional navigation button
    feat: add banner
    feat: add social links
    feat: add physical security section
    feat: add real social icons
    ```
    
- `fix:` - fixed a bug in previously implemented functionality. Examples:
    
    ```
    fix: implement correct loading data from youtube
    fix: change layout for video items to fix bugs
    fix: relayout header for firefox
    fix: adjust social links for mobile
    ```
    
- `refactor:` - I didn't add any new functionality/didn't change the behavior. I put the files in other places, deleted them, added them. Changed the formatting of the code (white-space, formatting, missing semi-columns, etc). Improved the algorithm, without changing the functionality. Examples:
    
    ```
    refactor: change structure of the project
    refactor: rename vars for better readability
    refactor: apply eslint
    refactor: apply prettier
    ```
    
- `docs:` - used when working with the documentation/README of the project. Examples:
    
    ```
    docs: update readme with additional information
    docs: update description of run() method
    ```
