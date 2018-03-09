# RTanque with Gosu

The `rtanque-gosu` gem provides a graphical interface for
[RTanque](https://github.com/awilliams/RTanque) using the
[Gosu](https://www.libgosu.org/) graphics library.

**Note:** This is very much in development but comments are appreciated.

## Quick start

In a new directory create the file `Gemfile` containing:

```ruby
source 'https://rubygems.org'

gem 'rtanque', git: 'https://github.com/awilliams/RTanque', branch: '0.2'
gem 'rtanque-gosu', git: 'https://github.com/jrmhaig/RTanque-gosu'
```

and execute:


```bash
bundle install
bundle exec rtanque init
```

Edit the `settings.yml` file that is created to include the line:

```yaml
  screen: gosu
```

and then start the battle with:

```bash
bundle exec rtanque start
```
