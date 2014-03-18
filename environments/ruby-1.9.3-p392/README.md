## C-Ruby ruby-1.9.3-p392 Environment


### Gem environment

    $ gem environment
    
    RubyGems Environment:
      - RUBYGEMS VERSION: 1.8.24
      - RUBY VERSION: 1.9.3 (2013-02-22 patchlevel 392) [x86_64-linux]
      - INSTALLATION DIRECTORY: /usr/local/rvm/gems/ruby-1.9.3-p392
      - RUBY EXECUTABLE: /usr/local/rvm/rubies/ruby-1.9.3-p392/bin/ruby
      - EXECUTABLE DIRECTORY: /usr/local/rvm/gems/ruby-1.9.3-p392/bin
      - RUBYGEMS PLATFORMS:
        - ruby
        - x86_64-linux
      - GEM PATHS:
         - /usr/local/rvm/gems/ruby-1.9.3-p392
         - /usr/local/rvm/gems/ruby-1.9.3-p392@global
      - GEM CONFIGURATION:
         - :update_sources => true
         - :verbose => true
         - :benchmark => false
         - :backtrace => false
         - :bulk_threshold => 1000
      - REMOTE SOURCES:
         - http://rubygems.org/


### Other software dependencies

* rvm: rvm 1.25.14 (stable)
* OS: CentOS release 6.3 (Final) x86_64
* Telephony Platform: Asterisk 1.8.13.0
* Application state
   * Punchblock branch: feature/dtmf_recognizer_leak
   * Punchblock sha1: adhearsion/punchblock@afb3c6b
   * punchblock-issue-memleak sha1: ccb5533


### Monitoring performed

The following tail shows any serious ERRORs that may occur during the test.

    tail -F /tmp/ahn-gc-log adhearsion.log | grep --color 'ERROR'

Additionally, the following watch is one way to show memory growth of the Adhearsion process over time:

    watch -n 5 --differences=cumulative 'ps faux | egrep "$(cat adhearsion.pid)|^USER"'

