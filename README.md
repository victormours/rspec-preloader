rspec-preloader
===============
A git backed preloader for rspec.

Life is too short to be waiting for your tests to load.
---

So you like TDD, but waiting for your specs to load is sucking the fun out of the process? We've got you covered.

rspec-preloader loads your `spec_helper.rb` so that your tests can be started almost instantly. No more waiting for your gems and your whole environment to load.

Installing
---
No surprises:
```
  gem install rspec-preloader
```

Or in your Gemfile
```
  gem 'rspec-preloader'
```


Prereqs
---
This will only work if you're using git and your spec files require `spec/spec_helper.rb` to run.

rspec-preloader will load all modified non-spec ruby files, but not untracked files.

Usage
---

So you're test driving some cool class? Great! Once you write your first test, let's make sure that bad boy is red.
```
  $rspec-preloader spec/models/some_cool_class_spec.rb
```
This will run `rspec spec/models/some_cool_class_spec.rb` and wait for additional input.

Now write some code to make the test green, go back to your shell and press Enter.

This will instantly run `rspec spec/models/some_cool_class_spec.rb` again.

Now refactor, and rerun as many times as you want.

Once you're done, Control-C out of the preloader.

If you want to run rspec with any other arguments, you can give them to the preloader instead of pressing Enter.


rspec-preloader will pass your input to rspec as is, so you can use any input rspec would accept, including specific line numbers or formatting options.

How it works
---
This is what happens under the hood :
- Fork a process that loads `spec/spec_helper.rb`, and waits for input.
- When input is given, find which non-spec ruby files have been modified using git
- load them
- run rspec in the forked process with the given input (or the original options if the input is empty)
- start over

Issues
---
Things tend to get weird if you're opening a `pry` console from your tests.

If you find any other issue, open it on Github, I'd be really happy to read about it and find a fix.

Contributing
---
Contributions welcome! Just fork it and send a pull request.

This gem is under the MIT license by the way.

