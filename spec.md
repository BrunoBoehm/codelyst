# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
- [x] Use ActiveRecord for storing information in a database
- [x] Include more than one model class (list of model class names e.g. User, Post, Category)
- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Posts)
- [x] Include user accounts
- [x] Ensure that users can't modify content created by other users
- [ ] Include user input validations
- [ ] Display validation failures to user with error message (example form URL e.g. /posts/new)
- [ ] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message

## Questions
- How to add version id starting from 1 for each list
- Flash could be just once in config.ru and environment.rb ?
- How to sanitize form params like strong parameters require.permit in rails?
- What security measures for any Sinatra App (CSRF...)?