rspec-preloader
===============

Life is too short to be waiting for your tests to load.
---

![rspec-preloader](https://cloud.githubusercontent.com/assets/1840367/7346923/71b0b9ea-ece3-11e4-8423-be241b365d50.gif)


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

Command Line Usage
---

```
  $rspec-preloader spec/models/some_cool_class_spec.rb
```
This will run `rspec spec/models/some_cool_class_spec.rb` and wait for additional input.

Now write some code to make the test green, go back to your shell and press Up and Enter.

This will instantly run `rspec spec/models/some_cool_class_spec.rb` again.

Now refactor, and rerun as many times as you want.

Once you're done, Control-D or `exit` out of the preloader.

If you want to run rspec with any other arguments, you can give them to the preloader readline or when calling the command.

Client/Server Usage
---

```
$ cd /my/cool/project
$ rspec-preloader-server
```
And then run `rspec-preloader-client` just like you would usually run `rspec`.
Restart your server each time you commit (see the How it works session to find out why).


rspec-preloader will pass your input to rspec as is, so you can use any input rspec would accept, including specific line numbers or formatting options.
Only files from `app/` and `lib/` will be reloaded. If you modify spec helpers or spec support files, you should probably restart the preloader.

Working with Docker
---

You can use the client/server mode to preload an app running inside a docker container.
For example:
```
$ docker-compose run -p 8787:8787 web rspec-preloader-server
```
And then in an other shell
```
$ rspec-preloader-client --server $(docker-machine ip) spec/my_class_spec.rb:12
```

How it works
---
This is what happens under the hood :
- require `spec/spec_helper.rb`, and waits for input.
- fork a process and run the tests in that process
- wait for the next command
- fork
- find which ruby files in `app/` and `lib/` have been modified using git
- load them
- run rspec in the forked process with the given input
- start over

Issues
---
Some frameworks like Grape don't like having client code reloaded a bunch or time.
When working with these, your specs might be red and magically go back to green when you restart the preloader.
Hopefully, I haven't yet faced the case where a spec is green with the preloader and red without it, but you never know.

If you find any other issue, open it on Github, I'd be really happy to read about it and find a fix.

Contributing
---
Contributions welcome! Just fork it and send a pull request.

This gem is under the MIT license by the way.

